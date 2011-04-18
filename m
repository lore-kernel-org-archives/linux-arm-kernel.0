From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Apr 2011 09:10:45 +0200
Subject: [RFC 0/4] convert stmp into mxs and delete the obsolete platform
In-Reply-To: <20110418051602.GC11578@pengutronix.de>
References: <1303093838-23959-1-git-send-email-w.sang@pengutronix.de>
	<201104180707.04176.arnd@arndb.de>
	<20110418051602.GC11578@pengutronix.de>
Message-ID: <201104180910.45599.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 April 2011, Wolfram Sang wrote:
> From 25959b361a5d4af3138d70f5dfc8c357bee90170 Mon Sep 17 00:00:00 2001
> From: Wolfram Sang <w.sang@pengutronix.de>
> Date: Sun, 17 Apr 2011 19:49:28 +0200
> Subject: [RFC 1/4] arm: mach-mxs: add stmp378x-devb
> 
> STMP378x and MX23 are the same. There is a mach-stmp378x, however, it has a lot
> of reinvented interfaces, leaking all sorts of mach-specific functions into the
> drivers. One example is the dmaengine which does not use the linux
> dmaengine-API but some privately exported symbols. This makes generic use of
> the drivers impossible. mach-mxs does it better, so convert the board to
> mach-mxs. After that, it is possible to delete all stmp-specific code which
> should ease further ARM-consolidation.
> 
> Compile tested only due to no hardware (seems not available anymore).
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

Ok, I guess there is not much that anyone can really complain about here.
What about the arch/arm/mach-stmp37xx/stmp37xx_devb.c file? You don't seem
to have a replacement for that machine.

Also, I noticed that the same series that added support for the platform
also added a few device drivers:
 * drivers/rtc/rtc-stmp3xxx.c
 * drivers/spi/spi_stmp.c
 * drivers/watchdog/stmp3xxx_wdt.c

Are these still used by the new code, and shared with the other i.MX23
code, or is there more duplication?

Finally, there are defconfig files:
 * arch/arm/configs/stmp378x_defconfig
 * arch/arm/configs/stmp37xx_defconfig

I would guess that these need to be updated.

	Arnd
