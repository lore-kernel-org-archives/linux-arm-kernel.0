From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 23 Feb 2015 16:59:26 +0100
Subject: [PATCH 0/3] Enable R-Mobile Reset Driver
Message-ID: <1424707169-23007-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series enables the R-Mobile Reset Driver, which is now in
v4.0-rc1. It can be used to restart DT-based R-Mobile APE6 (r8a73a4),
R-Mobile A1 (r8a7740), and SH-Mobile AG5 (sh73a0) through the
system-controller nodes that have been added for PM Domain support.
This series also removes the no longer needed restart callbacks on
multiplatform r8a7740 and sh73a0.
        
More detailed depencencies are in the individual patches.

Thanks for applying!

Geert Uytterhoeven (3):
  ARM: shmobile: Enable R-Mobile reset driver in multiplatform defconfig
  ARM: shmobile: r8a7740: Remove restart callback
  ARM: shmobile: sh73a0: Remove restart callback

 arch/arm/configs/shmobile_defconfig    | 3 +++
 arch/arm/mach-shmobile/setup-r8a7740.c | 8 --------
 arch/arm/mach-shmobile/setup-sh73a0.c  | 8 --------
 3 files changed, 3 insertions(+), 16 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
