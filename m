From: kbeldan@baylibre.com (Karl Beldan)
Date: Wed, 10 Aug 2016 11:00:28 +0000
Subject: [PATCH v2 0/4] Add DT support for NAND to LCDK
Message-ID: <20160810110032.29295-1-kbeldan@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes from v1:
 - s/cs2/cs3
 - kept "ti,.." only nand properties (the adjustments made by
   nand_davinci_probe are broken)
 - replaced v1_1/4:
     "memory: ti-aemif: Get a named clock rather than an unnamed one"
   with v2_1/4:
     "davinci: da8xx-dt: Add ti-aemif lookup for clock matching"
 - Make the same improvements for the EVM (and retire nand_cs3)

Karl Beldan (4):
  ARM: davinci: da8xx-dt: Add ti-aemif lookup for clock matching
  ARM: davinci_all_defconfig: Enable AEMIF as a module
  ARM: dts: da850,da850-evm: Add an aemif node and use it for the NAND
  ARM: dts: da850-lcdk: Add NAND to DT

 arch/arm/boot/dts/da850-evm.dts        |  49 +++++++++++++--
 arch/arm/boot/dts/da850-lcdk.dts       | 107 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/da850.dtsi           |  19 +++---
 arch/arm/configs/davinci_all_defconfig |   2 +
 arch/arm/mach-davinci/da850.c          |   1 +
 arch/arm/mach-davinci/da8xx-dt.c       |   1 +
 6 files changed, 163 insertions(+), 16 deletions(-)

-- 
2.9.2
