From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 20 Jan 2015 13:51:37 +0100
Subject: [PATCH 0/9] ARM: shmobile: r8a73a4/ape6evm multiplatform
Message-ID: <1421758306-24838-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series transitions the r8a73a4/ape6evm platform to support
multiplatform only:
  - Add CCF information to DT,
  - Disable legacy clock if CCF is used,
  - Add Bus State Controller node, and move the Ethernet node to it,
  - Remove ape6evm-reference,
  - Remove ape6evm-legacy and legacy support code.

This series is based on renesas-drivers-2015-01-19-v3.19-rc5.
It depends on renesas-devel-20150119-v3.19-rc5 (code-wise) and
clk-shmobile-for-3.20 (functionality-wise), for which I've sent a pull
request to Mike Turquette yesterday.

All of this was untested by me due to lack of hardware.
As Mike had previously acked the r8a73a4 CCF implementation, it's safe
to apply after testing.

Thanks!

Geert Uytterhoeven (2):
  ARM: shmobile: r8a73a4 dtsi: Add Bus State Controller node
  ARM: shmobile: ape6evm dts: Move Ethernet node to BSC

Laurent Pinchart (1):
  ARM: shmobile: r8a73a4: Remove legacy code

Ulrich Hecht (6):
  ARM: shmobile: r8a73a4: Add CPG register bits header
  ARM: shmobile: r8a73a4: Common clock framework DT description
  ARM: shmobile: ape6evm: Disable legacy clock initialization
  ARM: shmobile: r8a73a4: Add MSTP clock assignments to DT
  ARM: shmobile: ape6evm-reference: Remove board C code and DT file
  ARM: shmobile: r8a73a4: ape6evm: Remove legacy platform

 Documentation/devicetree/bindings/arm/shmobile.txt |   2 -
 MAINTAINERS                                        |   1 -
 arch/arm/boot/dts/Makefile                         |   2 -
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts    | 156 -----
 arch/arm/boot/dts/r8a73a4-ape6evm.dts              |  35 +-
 arch/arm/boot/dts/r8a73a4.dtsi                     | 333 +++++++++++
 arch/arm/configs/ape6evm_defconfig                 | 109 ----
 arch/arm/mach-shmobile/Kconfig                     |  25 -
 arch/arm/mach-shmobile/Makefile                    |   3 -
 arch/arm/mach-shmobile/Makefile.boot               |   2 -
 arch/arm/mach-shmobile/board-ape6evm-reference.c   |  60 --
 arch/arm/mach-shmobile/board-ape6evm.c             | 286 ---------
 arch/arm/mach-shmobile/clock-r8a73a4.c             | 659 ---------------------
 arch/arm/mach-shmobile/r8a73a4.h                   |  17 -
 arch/arm/mach-shmobile/setup-r8a73a4.c             | 273 +--------
 include/dt-bindings/clock/r8a73a4-clock.h          |  62 ++
 16 files changed, 412 insertions(+), 1613 deletions(-)
 delete mode 100644 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
 delete mode 100644 arch/arm/configs/ape6evm_defconfig
 delete mode 100644 arch/arm/mach-shmobile/board-ape6evm-reference.c
 delete mode 100644 arch/arm/mach-shmobile/board-ape6evm.c
 delete mode 100644 arch/arm/mach-shmobile/clock-r8a73a4.c
 delete mode 100644 arch/arm/mach-shmobile/r8a73a4.h
 create mode 100644 include/dt-bindings/clock/r8a73a4-clock.h

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
