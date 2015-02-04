From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed,  4 Feb 2015 15:15:10 +0100
Subject: [PATCH v2 0/5] ARM: shmobile: r8a7740/armadillo: Migrate to generic
 l2c OF
Message-ID: <1423059315-28519-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series migrates the DT-based generic r8a7740 platform and
the armadillo legacy platform from calling l2x0_of_init() to the
generic l2c OF initialization.

Changes in v2:
  - Fix interrupt reference in DT,
  - Describe L2 better in DT,
  - Keep only {,~}L2C_AUX_CTRL_SHARED_OVERRIDE in
    machine_desc.l2c_aux_{val,mask}, as there's no DT property for
    this.
  - Add L1 cache to DT.

Dependencies:
  - The first patch depends on r8a7740 DT PM Domain support (tag
    renesas-dt2-for-v3.20 in Simon's repository),
  - Although there are separate patches for dtsi, SoC code, and board code,
    there are dependencies among the individual patches:
      - patches 2, 3, and 5 depend on patch 1,
      - patch 4 depends on patches 2 and 3 (and thus 1).

Note that this conversion should be done on sh73a0, r8a7778, and r8a7779,
too.

This was tested on armadillo-legacy and armadillo-multiplatform.

Thanks!

Geert Uytterhoeven (5):
  ARM: shmobile: r8a7740 dtsi: Add cache-controller node
  ARM: shmobile: r8a7740: Migrate to generic l2c OF initialization
  ARM: shmobile: armadillo legacy: Migrate to generic l2c OF
    initialization
  ARM: shmobile: r8a7740: Remove mapping of L2 cache controller
    registers
  ARM: shmobile: r8a7740: Add L1 cache information to CPU node

 arch/arm/boot/dts/r8a7740.dtsi                 | 24 ++++++++++++++++++++++++
 arch/arm/mach-shmobile/board-armadillo800eva.c |  8 ++------
 arch/arm/mach-shmobile/setup-r8a7740.c         | 18 ++----------------
 3 files changed, 28 insertions(+), 22 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
