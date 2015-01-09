From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri,  9 Jan 2015 14:24:26 +0100
Subject: [PATCH 0/4] ARM: shmobile: sh73a0/kzm9g: Complete multiplatform
 support
Message-ID: <1420809866-4330-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series completes the migration from kzm9g-reference (legacy
DT based) to kzm9g-multiplatform (ARM multiplatform DT based with
common clock framework).

  - The first two patches fix Ethernet on kzm9g, by adding a Bus State
    Controller node, as introduced in "[PATCH v3 0/4] drivers: bus:
    Add Simple Power-Managed Bus", and moving the Ethernet node to it,
  - The third path enables kzm9g support in shmobile_defconfig,
  - The fourth patch removes all kzm9g-reference support, now the
    sh73a0 generic multiplatform case has the same feature set
    (better, it provides 16 MiB more RAM!).

Thanks for applying!

Geert Uytterhoeven (4):
  ARM: shmobile: sh73a0 dtsi: Add Bus State Controller node
  ARM: shmobile: kzm9g dts: Move Ethernet node to BSC
  ARM: shmobile: Enable kzm9g board in multiplatform defconfig
  ARM: shmobile: kzm9g-reference: Remove board C code and DT file

 Documentation/devicetree/bindings/arm/shmobile.txt |   2 -
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       | 398 ---------------------
 arch/arm/boot/dts/sh73a0-kzm9g.dts                 |  28 +-
 arch/arm/boot/dts/sh73a0.dtsi                      |  10 +
 arch/arm/configs/shmobile_defconfig                |  19 +-
 arch/arm/mach-shmobile/Kconfig                     |  14 -
 arch/arm/mach-shmobile/Makefile                    |   1 -
 arch/arm/mach-shmobile/Makefile.boot               |   1 -
 arch/arm/mach-shmobile/board-kzm9g-reference.c     |  62 ----
 arch/arm/mach-shmobile/include/mach/zboot.h        |   2 +-
 11 files changed, 43 insertions(+), 497 deletions(-)
 delete mode 100644 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
 delete mode 100644 arch/arm/mach-shmobile/board-kzm9g-reference.c

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
