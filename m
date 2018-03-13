From: tmaimon77@gmail.com (Tomer Maimon)
Date: Tue, 13 Mar 2018 15:32:08 +0200
Subject: [PATCH v12 0/3] arm: npcm: add basic support for Nuvoton BMCs
Message-ID: <1520947931-15426-1-git-send-email-tmaimon77@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addressed comments from:
 - Arnd: https://www.spinics.net/lists/arm-kernel/msg639249.html

Summary of changes since previous update:
 - Modify mach-npcm Kconfig to support all NPCM7XX family.
 - Modify mach-npcm Makefile.
 - Adding NPCM730 chip support.
 - Adding L2 Cache values to initialize the L2 Cache.

All changes tested on Nuvoton NPCM750 EVB.

Tomer Maimon (3):
  arm: npcm: add basic support for Nuvoton BMCs
  arm: dts: add Nuvoton NPCM750 device tree
  MAINTAINERS: Add entry for the Nuvoton NPCM architecture

 .../arm/cpu-enable-method/nuvoton,npcm750-smp      |  42 ++++++
 .../devicetree/bindings/arm/npcm/npcm.txt          |   6 +
 MAINTAINERS                                        |  14 ++
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/nuvoton-npcm750-evb.dts          |  35 +++++
 arch/arm/boot/dts/nuvoton-npcm750.dtsi             | 165 +++++++++++++++++++++
 arch/arm/mach-npcm/Kconfig                         |  30 ++++
 arch/arm/mach-npcm/Makefile                        |   6 +
 arch/arm/mach-npcm/headsmp.S                       |  17 +++
 arch/arm/mach-npcm/npcm7xx.c                       |  23 +++
 arch/arm/mach-npcm/platsmp.c                       |  81 ++++++++++
 13 files changed, 424 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cpu-enable-method/nuvoton,npcm750-smp
 create mode 100644 Documentation/devicetree/bindings/arm/npcm/npcm.txt
 create mode 100644 arch/arm/boot/dts/nuvoton-npcm750-evb.dts
 create mode 100644 arch/arm/boot/dts/nuvoton-npcm750.dtsi
 create mode 100644 arch/arm/mach-npcm/Kconfig
 create mode 100644 arch/arm/mach-npcm/Makefile
 create mode 100644 arch/arm/mach-npcm/headsmp.S
 create mode 100644 arch/arm/mach-npcm/npcm7xx.c
 create mode 100644 arch/arm/mach-npcm/platsmp.c

-- 
2.14.1
