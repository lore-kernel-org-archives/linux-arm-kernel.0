From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 19 Nov 2013 11:20:19 +0100
Subject: [PATCH v4 0/4] Energy Micro efm32 support
In-Reply-To: <20131104105836.GI14892@pengutronix.de>
References: <20131104105836.GI14892@pengutronix.de>
Message-ID: <20131119102019.GF28642@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Nov 04, 2013 at 11:58:36AM +0100, Uwe Kleine-K?nig wrote:
> now that 3.12 is out, I patted my efm32 tree and I consider the base
> platform support ready for merging. I put it into my for-next branch at
> 
> 	git://git.pengutronix.de/git/ukl/linux.git for-next
> 
> so it should make it into the next next. I target 3.14-rc1 to make it
> in. The patches have a few runtime (but no compile-time) dependencies on
> these patches:
> 
> 	ARM: call of_clk_init from default time_init handler
> 	clocksource: Provide timekeeping for efm32 SoCs
> 	clk: new driver for efm32 SoC
> 
> All but the last patch are already in next, Mike promised to take the
> last one. DEBUG_LL is broken without
> 
> 	ARM: DEBUG_LL on efm32 SoCs
I'd like to get patch 4 (ARM: new platform for Energy Micro's EFM32
Cortex-M3 SoCs) in. In the state as it was sent here it build depends on
patches 1 - 3.  Patches 2 and 3 are in Russell's patch tracker (7890/1
and 7889/1). What do you think about patch 1? Some of the
NEED_MACH_TIMEX_H are already fixed by patches that I sent out. The
options here are:

	- rework patch 4 to not depend on patch 1 (easy)
	- merge v5 of patch 1 (which is conservative, i.e. introduces
	  more NEED_MACH_TIMEX_H as probably will be needed in 3.14-rc1
	  and fix up later)
	- depend on all sent patches and coordinate accordingly (at
	  least: watchdog, clocksource, rtc).

I'd prefer the 2nd option as I didn't get Acks on all patches needed for
the third. What do you think?

Russell, if you are happy with patches 2 and 3 and would apply them to
your tree I could prepare a branch for the arm-soc people to pull which
bases on your tree and has patch 1 (v5).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
