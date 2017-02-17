From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 17 Feb 2017 17:10:33 +0100
Subject: [PATCH 0/3] ARM: PM: Drop useless checks for PM_SUSPEND_STANDBY
Message-ID: <1487347836-14427-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi all,

The system suspend implementations for DaVinci, OMAP, and SoCFPGA use
the standard suspend_valid_only_mem() for their
platform_suspend_ops.valid() callbacks.  Hence their
platform_suspend_ops.enter() callbacks will never be called with state
equal to PM_SUSPEND_STANDBY, and checks for this can thus be removed.

Thanks for your comments!

Geert Uytterhoeven (3):
  ARM: davinci: PM: Drop useless check for PM_SUSPEND_STANDBY
  ARM: OMAP: PM: Drop useless check for PM_SUSPEND_STANDBY
  ARM: socfpga: PM: Drop useless check for PM_SUSPEND_STANDBY

 arch/arm/mach-davinci/pm.c | 1 -
 arch/arm/mach-omap1/pm.c   | 1 -
 arch/arm/mach-omap2/pm.c   | 1 -
 arch/arm/mach-socfpga/pm.c | 1 -
 4 files changed, 4 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
