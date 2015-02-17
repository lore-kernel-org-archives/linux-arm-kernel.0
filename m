From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 17 Feb 2015 16:04:40 +0100
Subject: [PATCH v4 0/6] ARM: shmobile: r8a73a4/ape6evm: Complete multiplatform
 support
Message-ID: <1424185486-3017-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series completes the migration from aep6evm-legacy (legacy board
code) and ape6evm-reference (legacy DT based) to ape6evm-multiplatform (ARM
multiplatform DT based with common clock framework).

It depends on Simon's branch simple-pm-bus-for-v3.21.

  - The first two patches fix Ethernet on ape6evm, by adding a Bus State
    Controller node, and moving the Ethernet node to it, and thus depends
    on Simon's branch simple-pm-bus-for-v3.21,
  - The third patch moves the pfc node after the irqc nodes, to work around
    a bug in the core OF proving code,
  - The fourth and fifth patch remove all ape6evm-legacy and
    ape6evm-reference support, now the r8a73a4 generic multiplatform case
    has the same feature set,
  - The sixth patch is new, and removes the now superfluous console=
    bootargs parameter.

Thanks for applying!

Geert Uytterhoeven (4):
  ARM: shmobile: r8a73a4 dtsi: Add Bus State Controller node
  ARM: shmobile: ape6evm dts: Move Ethernet node to BSC
  ARM: shmobile: r8a73a4: Move pfc node to work around probe ordering
    bug
  ARM: shmobile: ape6evm dts: Drop console= bootargs parameter

Ulrich Hecht (2):
  ARM: shmobile: ape6evm-reference: Remove board C code and DT file
  ARM: shmobile: r8a73a4: ape6evm: Remove legacy platform

 Documentation/devicetree/bindings/arm/shmobile.txt |   2 -
 MAINTAINERS                                        |   1 -
 arch/arm/boot/dts/Makefile                         |   2 -
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts    | 156 -----------
 arch/arm/boot/dts/r8a73a4-ape6evm.dts              |  37 ++-
 arch/arm/boot/dts/r8a73a4.dtsi                     |  56 ++--
 arch/arm/configs/ape6evm_defconfig                 | 109 --------
 arch/arm/mach-shmobile/Kconfig                     |  25 --
 arch/arm/mach-shmobile/Makefile                    |   2 -
 arch/arm/mach-shmobile/Makefile.boot               |   2 -
 arch/arm/mach-shmobile/board-ape6evm-reference.c   |  61 ----
 arch/arm/mach-shmobile/board-ape6evm.c             | 306 ---------------------
 12 files changed, 49 insertions(+), 710 deletions(-)
 delete mode 100644 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
 delete mode 100644 arch/arm/configs/ape6evm_defconfig
 delete mode 100644 arch/arm/mach-shmobile/board-ape6evm-reference.c
 delete mode 100644 arch/arm/mach-shmobile/board-ape6evm.c

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
