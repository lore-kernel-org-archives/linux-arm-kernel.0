From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 17 Nov 2014 14:53:04 +0100
Subject: [PATCH 0/4] ARM: shmobile: r8a7740/armadillo: Migrate to generic l2c
 OF
Message-ID: <1416232388-2611-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series migrates the DT-based generic r8a7740 platform and the
armadillo legacy platform from calling l2x0_of_init() to the generic l2c OF
initialization.

Dependencies:
  - The first patch depends on "[PATCH v5 7/8] ARM: shmobile: r8a7740 dtsi: Add
    PM domain support", due to the pd_a3sm reference.
    However, that line can just be removed if the dependency is postponed.
  - Although there are separate patches for dtsi, SoC code, and board code,
    there are dependencies among the individual patches: patches 2 and 3 depend
    on patch 1, and patch 4 depends on patches 2 and 3 (and thus 1).

Note that this conversion should be applied to sh73a0, r8a7778, and r8a7779,
too. More about sh73a0 later.

Thanks!
	    
Geert Uytterhoeven (4):
  ARM: shmobile: r8a7740 dtsi: Add cache-controller node
  ARM: shmobile: r8a7740: Migrate to generic l2c OF initialization
  ARM: shmobile: armadillo legacy: Migrate to generic l2c OF
    initialization
  ARM: shmobile: r8a7740: Remove mapping of L2 cache controller
    registers

 arch/arm/boot/dts/r8a7740.dtsi                 | 11 +++++++++++
 arch/arm/mach-shmobile/board-armadillo800eva.c | 10 +++-------
 arch/arm/mach-shmobile/setup-r8a7740.c         | 20 +++-----------------
 3 files changed, 17 insertions(+), 24 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
