From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 18 May 2018 14:48:49 +0200
Subject: [PATCH 0/5] ARM: shmobile: rcar-gen2: Remove legacy SMP fallback code
Message-ID: <1526647734-1200-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

R-Car H2 and M2-W have been supporting SMP enablement from DT using the
"renesas,apmu" enable-method since v4.8.  A legacy fallback was left in
place for backwards compatibility with old DTBs.

This patch series removes the legacy SMP fallbacks for R-Car H2 and
M2-W, and consolidates their support in the common R-Car Gen2 machine
definition.

For testing, this series is available in the
topic/rcar2-legacy-smp-removal-v1 branch of my renesas-drivers git
repository at
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.

Thanks for applying!

Geert Uytterhoeven (5):
  ARM: shmobile: r8a7790: Remove legacy SMP fallback code
  ARM: shmobile: r8a7790: Use common R-Car Gen2 machine definition
  ARM: shmobile: r8a7791: Remove legacy SMP fallback code
  ARM: shmobile: r8a7791: Use common R-Car Gen2 machine definition
  ARM: shmobile: Remove unused shmobile_smp_init_fallback_ops()

 arch/arm/mach-shmobile/Makefile          |  4 --
 arch/arm/mach-shmobile/common.h          |  1 -
 arch/arm/mach-shmobile/platsmp.c         |  9 ----
 arch/arm/mach-shmobile/r8a7790.h         |  7 ----
 arch/arm/mach-shmobile/r8a7791.h         |  7 ----
 arch/arm/mach-shmobile/setup-r8a7790.c   | 38 -----------------
 arch/arm/mach-shmobile/setup-r8a7791.c   | 39 ------------------
 arch/arm/mach-shmobile/setup-rcar-gen2.c |  6 +--
 arch/arm/mach-shmobile/smp-r8a7790.c     | 71 --------------------------------
 arch/arm/mach-shmobile/smp-r8a7791.c     | 53 ------------------------
 10 files changed, 2 insertions(+), 233 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/r8a7790.h
 delete mode 100644 arch/arm/mach-shmobile/r8a7791.h
 delete mode 100644 arch/arm/mach-shmobile/setup-r8a7790.c
 delete mode 100644 arch/arm/mach-shmobile/setup-r8a7791.c
 delete mode 100644 arch/arm/mach-shmobile/smp-r8a7790.c
 delete mode 100644 arch/arm/mach-shmobile/smp-r8a7791.c

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
