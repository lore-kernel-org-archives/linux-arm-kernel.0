From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  4 Aug 2015 20:03:05 +0200
Subject: [PATCH 0/7] ARM: shmobile: Misc removals
Message-ID: <1438711392-23763-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series (against renesas-devel-20150804-v4.2-rc5) removes
various header files, source files, declarations and definitions that
are no longer in use.

Dependencies:
  - Patch 1 depends on v3.12,
  - Patches 2-5 depend on the sh73a0/kzm9g and r8a7740/armadillo legacy
    removal, which is in arm-soc/for-next,
  - Patches 6-7 depend on the r8a7779/marzen legacy removal, which is in
    marzen-board-removal-for-v4.3.

Note that I didn't remove the now unused r8a7779_init_pm_domains() et al
yet, as I need to have a closer look on what to retain for R-Car DT SYSC
PM Domains first.

Thanks!

Geert Uytterhoeven (7):
  ARM: shmobile: Remove unused declaration of
    r8a7778_add_standard_devices_dt()
  ARM: shmobile: Remove obsolete sh-gpio.h
  ARM: shmobile: Remove obsolete custom earlyprintk code
  ARM: shmobile: Remove obsolete intc.h
  ARM: shmobile: Remove obsolete legacy PM Domain leftovers
  ARM: shmobile: Remove obsolete earlytimer registration
  ARM: shmobile: Remove obsolete twd_local_timer declaration

 arch/arm/mach-shmobile/Makefile     |   2 +-
 arch/arm/mach-shmobile/common.h     |   3 -
 arch/arm/mach-shmobile/console.c    |  27 ----
 arch/arm/mach-shmobile/intc.h       | 295 ------------------------------------
 arch/arm/mach-shmobile/pm-rmobile.h |   9 --
 arch/arm/mach-shmobile/r8a7778.h    |   1 -
 arch/arm/mach-shmobile/sh-gpio.h    |  29 ----
 arch/arm/mach-shmobile/timer.c      |  21 ---
 8 files changed, 1 insertion(+), 386 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/console.c
 delete mode 100644 arch/arm/mach-shmobile/intc.h
 delete mode 100644 arch/arm/mach-shmobile/sh-gpio.h

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
