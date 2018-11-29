From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 29 Nov 2018 12:09:29 +0100
Subject: [PATCH 0/2] ARM: shmobile: R-Mobile: Clean up and move pm-rmobile
 driver
Message-ID: <20181129110931.11783-1-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This is a patch series for the pm-rmobile driver, used on R-Mobile A1 and
APE6, and on SH-Mobile AG5, to clean up the driver, move it to
drivers/soc/renesas/, and enable compile-testing.

Thanks!

Geert Uytterhoeven (2):
  ARM: shmobile: R-Mobile: Clean up struct rmobile_pm_domain
  ARM: shmobile: R-Mobile: Move pm-rmobile to drivers/soc/renesas/

 arch/arm/mach-shmobile/Kconfig                |  5 ---
 arch/arm/mach-shmobile/Makefile               |  1 -
 arch/arm/mach-shmobile/pm-rmobile.h           | 22 -----------
 drivers/soc/renesas/Kconfig                   |  7 +++-
 drivers/soc/renesas/Makefile                  |  1 +
 .../soc/renesas/rmobile-sysc.c                | 37 +++++++++----------
 6 files changed, 25 insertions(+), 48 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/pm-rmobile.h
 rename arch/arm/mach-shmobile/pm-rmobile.c => drivers/soc/renesas/rmobile-sysc.c (93%)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
