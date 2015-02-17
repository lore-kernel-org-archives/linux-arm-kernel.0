From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 17 Feb 2015 15:52:35 +0100
Subject: [PATCH v4 0/5] ARM: shmobile: sh73a0/kzm9g: Complete multiplatform
 support
Message-ID: <1424184760-1671-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series completes the migration from kzm9g-reference (legacy
DT based) to kzm9g-multiplatform (ARM multiplatform DT based with
common clock framework).

It depends on Simon's branch simple-pm-bus-for-v3.21.

  - The first two patches fix Ethernet on kzm9g, by adding a Bus State
    Controller node, and moving the Ethernet node to it, and thus depends
    on Simon's branch simple-pm-bus-for-v3.21,
  - The third patch removes all kzm9g-reference support, now the
    sh73a0 generic multiplatform case has the same feature set
    (better, it provides 16 MiB more RAM!),
  - The fourth patch fixes CONFIG_CPU_IDLE=y by adding a node for the TWD,
    which could not be done before, as the TWD driver doesn't support DT
    without CCF,
  - The fifth path is new, and removes the now unused function
    sh73a0_add_standard_devices_dt().
 
Thanks for applying!

Geert Uytterhoeven (5):
  ARM: shmobile: sh73a0 dtsi: Add Bus State Controller node
  ARM: shmobile: kzm9g dts: Move Ethernet node to BSC
  ARM: shmobile: kzm9g-reference: Remove board C code and DT file
  ARM: shmobile: sh73a0 dtsi: Add Cortex-A9 TWD node
  ARM: shmobile: sh73a0: Remove unused sh73a0_add_standard_devices_dt()

 Documentation/devicetree/bindings/arm/shmobile.txt |   2 -
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       | 398 ---------------------
 arch/arm/boot/dts/sh73a0-kzm9g.dts                 |  28 +-
 arch/arm/boot/dts/sh73a0.dtsi                      |  19 +
 arch/arm/mach-shmobile/Kconfig                     |  14 -
 arch/arm/mach-shmobile/Makefile                    |   1 -
 arch/arm/mach-shmobile/Makefile.boot               |   1 -
 arch/arm/mach-shmobile/board-kzm9g-reference.c     |  62 ----
 arch/arm/mach-shmobile/include/mach/zboot.h        |   2 +-
 arch/arm/mach-shmobile/setup-sh73a0.c              |   9 -
 arch/arm/mach-shmobile/sh73a0.h                    |   1 -
 12 files changed, 36 insertions(+), 504 deletions(-)
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
