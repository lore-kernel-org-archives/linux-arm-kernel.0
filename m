From: jgg@mellanox.com (Jason Gunthorpe)
Date: Mon, 27 Nov 2017 13:29:55 -0700
Subject: [PATCH] rtc: Allow rtc drivers to specify the tv_nsec value for
 ntp
In-Reply-To: <20171127201812.GB21126@piout.net>
References: <20171013175433.GA22062@obsidianresearch.com>
 <20171123095456.lkc4nkuzsd2q26mm@piout.net>
 <20171123112338.GN31757@n2100.armlinux.org.uk>
 <20171123120451.v74j3z2c5oodxlud@piout.net>
 <20171123125300.GO31757@n2100.armlinux.org.uk>
 <20171127201812.GB21126@piout.net>
Message-ID: <20171127202955.GF13962@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 09:18:12PM +0100, Alexandre Belloni wrote:
 
> Also, fixing systohc will not fix the offset for people using hwclock or
> any other tools (e.g. systemd).

When I was talking this over with Russel originally I imagined the
systohc fix as a first step, and we could eventually add an rtc API to
let user space do a precise write to the RTC, with the kernel taking
care of the required sleep, etc.

Jason
