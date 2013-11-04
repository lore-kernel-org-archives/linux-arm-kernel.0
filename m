From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 4 Nov 2013 11:58:36 +0100
Subject: [PATCH v4 0/4] Energy Micro efm32 support
Message-ID: <20131104105836.GI14892@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

now that 3.12 is out, I patted my efm32 tree and I consider the base
platform support ready for merging. I put it into my for-next branch at

	git://git.pengutronix.de/git/ukl/linux.git for-next

so it should make it into the next next. I target 3.14-rc1 to make it
in. The patches have a few runtime (but no compile-time) dependencies on
these patches:

	ARM: call of_clk_init from default time_init handler
	clocksource: Provide timekeeping for efm32 SoCs
	clk: new driver for efm32 SoC

All but the last patch are already in next, Mike promised to take the
last one. DEBUG_LL is broken without

	ARM: DEBUG_LL on efm32 SoCs

which already is in next, too. There are no device tree source files yet
as they have a compile time dependency on the clk patch above.

I'm not using multiarch here. I'm still unsure if it makes sense or not
to use it for v7-M, I'm sticking to not using it mainly because of
Russell's objections. Still the patch adding the platform is very small
now (just a trivial machine file, a defconfig and Makefile/Kconfig
adaptions) and is easily switched to multiarch if need be.

The complete and runnable tree is available in my master branch.

I suggest to let it go in via Russell as it has less potential to
conflict with arm-soc.

As the patches changed a bit I will repost them here. Note I called them
all "v4" even though patches 1 to 3 are really only (a resent of) v1.

Any feed back is welcome.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
