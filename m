From: 21cnbao@gmail.com (Barry Song)
Date: Sat, 18 May 2013 19:03:24 +0800
Subject: [alsa-devel] [PATCH v2] ASoC: dfbmcs320: make the driver common
 for other BT modules
In-Reply-To: <20130517111523.GM1627@sirena.org.uk>
References: <1368757177-15372-1-git-send-email-Baohua.Song@csr.com>
 <20130517111523.GM1627@sirena.org.uk>
Message-ID: <CAGsJ_4zjgLhNOiwGcTjvC6dP2XPqnmjzWF12pVPomU-ERH6YYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/5/17 Mark Brown <broonie@kernel.org>:
> On Fri, May 17, 2013 at 10:19:37AM +0800, Barry Song wrote:
>> DFBM-CS320 is only one of bluetooth modules using CSR bluetooth chips,
>> we don't want everyone to have a seperate codec driver. anyway, the
>> feature of Bluetooth handsfree is same on all platforms, so this patch
>> makes the DFBM-CS320 driver become a common BT handsfree driver.
>
> Sorry, should have thought of this before but why are we calling this
> "handsfree"?  It's just a generic bluetooth link as far as the host
> system is concerned, "bt-sco" might be more appropriate?

agree. BT SCO should be more suitable.

>
> Otherwise this looks OK for ASoC though I'd expect to see a change to
> registration of the OpenMoko BT device (perhaps I missed it though).

sorry. i don't understand. i would think OpenMOKO can also use this driver?

-barry
