From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Nov 2013 14:11:41 +0100
Subject: [PATCH v4 0/4] Energy Micro efm32 support
In-Reply-To: <20131119102019.GF28642@pengutronix.de>
References: <20131104105836.GI14892@pengutronix.de>
 <20131119102019.GF28642@pengutronix.de>
Message-ID: <201311191411.42273.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 November 2013, Uwe Kleine-K?nig wrote:
> I'd like to get patch 4 (ARM: new platform for Energy Micro's EFM32
> Cortex-M3 SoCs) in. In the state as it was sent here it build depends on
> patches 1 - 3.  Patches 2 and 3 are in Russell's patch tracker (7890/1
> and 7889/1). What do you think about patch 1? Some of the
> NEED_MACH_TIMEX_H are already fixed by patches that I sent out. The
> options here are:
> 
>         - rework patch 4 to not depend on patch 1 (easy)
>         - merge v5 of patch 1 (which is conservative, i.e. introduces
>           more NEED_MACH_TIMEX_H as probably will be needed in 3.14-rc1
>           and fix up later)

These both sound fine to me in retrospect, unless someone has objections.
I would prefer the Kconfig solution I suggested (with the help text
fixed to address Russell's objections, and the list of platforms changed
to match your v4 patch), but I don't want to force you to go through
more revisions for this.

>         - depend on all sent patches and coordinate accordingly (at
>           least: watchdog, clocksource, rtc).
> 
> I'd prefer the 2nd option as I didn't get Acks on all patches needed for
> the third. What do you think?

Makes sense. It would be nice to still follow up on those patches
and merge them eventually.

> Russell, if you are happy with patches 2 and 3 and would apply them to
> your tree I could prepare a branch for the arm-soc people to pull which
> bases on your tree and has patch 1 (v5).

Did you get in touch with Jonathan about the patch set to make ARMv7-M
support coexist with multiplatform? I think that would be the best
solution in the long run, and IIRC there were no more objections at the
ARM mini summit to the draft patch.

	Arnd
