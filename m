From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 17 Apr 2018 11:20:21 -0700
Subject: atmel_mxt_ts on droid4: powersave seems to break the driver
In-Reply-To: <20180417073811.GA9450@amd>
References: <20180417073811.GA9450@amd>
Message-ID: <20180417182021.GA67621@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On Tue, Apr 17, 2018 at 09:38:11AM +0200, Pavel Machek wrote:
> HI!
> 
> v4.17-rc1 on motorola droid 4.
> 
> If I disable/reenable touschreen with xinput, it fails, with this in
> the logs:
> 
> [ 1633.749450] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
> [ 1655.938751] atmel_mxt_ts 1-004a: __mxt_read_reg: i2c transfer
> failed (-121)
> [ 1655.945800] atmel_mxt_ts 1-004a: Failed to read T44 and T5 (-121)
> [ 1663.829498] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
> 
> Unfortunately, xscreensaver seems to break it in a similar way.
> 

There were a few changes to the Atmel driver, ending with commit
96a938aa214e965d5b4a2f10443b29cad14289b9, but they mostly dealt with
removal of platform data and moving to generic device properties...
Can you try bisecting this series:

git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git ib-chrome-platform-input-atmel-mx-ts-platform-removal

Thanks!

-- 
Dmitry
