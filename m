From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Mon, 16 Nov 2015 22:19:33 +0000
Subject: [PATCH v3] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <alpine.LFD.2.20.1511161605070.5826@knanqh.ubzr>
References: <1447362108-4333-1-git-send-email-chris.brandt@renesas.com>
 <1447697140-4099-1-git-send-email-chris.brandt@renesas.com>
 <alpine.LFD.2.20.1511161515100.5826@knanqh.ubzr>
 <HK2PR06MB05619FACB3725B6F5B2299718A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511161605070.5826@knanqh.ubzr>
Message-ID: <HK2PR06MB056142FFDA4E99A764DF9ECB8A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> If you are convinced that you need kernel XIP, then you normally would
> want _not_ to use initramfs at all.

True, but in trying to test upstream kernels, initramfs was easier than
fighting with device drivers (although now I've just switched to using
memory mapped mtd-rom).


> Forget it.  XIP kernel is simply completely broken at the moment.  

Yes, there were multiple things wrong that took me a while to find, but
once you get them all working, it's pretty cool. Note, the Kconfig
issues are going to be a bit harder to get approval.


> New sections (lots of them) were added as well since the introduction
> of XIP kernel with no consideration for XIP usage.

So I've noticed. As far as I can tell, the XIP kernel stuff broke years
ago.


> I think the only way to fix it properly is to have a separate linker
> script for XIP usage with proper (and obvious) section placement.

I guess then the parts of the kernel that refer to section locations
need to be looked at again. As you can see from my other patches,
there's a bit of miss-match that I was trying to align.


So at this point...I'm assume all my XIP 'hacks' are being rejected.

As for making a new XIP-only linker script, note that I really only
work with the ARMv7. I know the M4 and M5 guys do XIP_KERNEL builds,
but I've got no way of testing their XIP_KERNEL builds or knowing
what will break.


Chris
