From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 16 Jun 2017 17:24:27 +0530
Subject: [PATCH 00/12] ARM: dts: Add iodelay data for MMC
Message-ID: <20170616115439.8508-1-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the second part of the series originally sent as
part of [1] with one important modification.

Now PINCTRL_TI_IODELAY will be enabled for SOC_DRA7XX
(in mach-omap2/Kconfig) so that omap2plus_defconfig or
multi_v7_defconfig don't have to be modified.

This series only adds data and it won't be used until
the next series which adds UHS support to omap_hsmmc driver.

This series is created on top of [2], [3] and [4].

[1] -> https://lkml.org/lkml/2017/5/19/196
[2] -> https://lkml.org/lkml/2017/6/9/206
[3] -> https://lkml.org/lkml/2017/6/7/169
[4] -> https://www.spinics.net/lists/arm-kernel/msg586215.html /
       http://www.spinics.net/lists/devicetree/msg180747.html 

Kishon Vijay Abraham I (9):
  ARM: OMAP2+: Select PINCTRL_TI_IODELAY for SOC_DRA7XX
  ARM: dts: dra7-evm: Add pinmux configuration for MMC
  ARM: dts: am57xx-beagle-x15: Add pinmux configuration for MMC
  ARM: dts: am57xx-idk: Move common MMC/SD properties to common file
  ARM: dts: am571x-idk: Add pinmux configuration for MMC
  ARM: dts: am572x-idk: Add pinmux configuration for MMC
  ARM: dts: dra72-evm: Add pinmux configuration for MMC
  ARM: dts: dra72-evm-revc: Add pinmux configuration for MMC
  ARM: dts: dra71-evm: Add pinmux configuration for MMC

Sekhar Nori (2):
  ARM: dts: dra72x: Create a common file with MMC/SD IOdelay data
  ARM: dts: dra74x: Create a common file with MMC/SD IOdelay data

Tony Lindgren (1):
  ARM: dts: Add dra7 iodelay configuration

 arch/arm/boot/dts/am571x-idk.dts                |  26 +-
 arch/arm/boot/dts/am572x-idk.dts                |  27 +-
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |  29 +-
 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts   |  15 +
 arch/arm/boot/dts/am57xx-beagle-x15.dts         |  11 +
 arch/arm/boot/dts/am57xx-idk-common.dtsi        |   8 +
 arch/arm/boot/dts/dra7-evm.dts                  |  22 +-
 arch/arm/boot/dts/dra7.dtsi                     |   8 +
 arch/arm/boot/dts/dra71-evm.dts                 |  14 +
 arch/arm/boot/dts/dra72-evm-revc.dts            |  14 +
 arch/arm/boot/dts/dra72-evm.dts                 |  14 +
 arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi       | 350 +++++++++++++
 arch/arm/boot/dts/dra74x-mmc-iodelay.dtsi       | 647 ++++++++++++++++++++++++
 arch/arm/mach-omap2/Kconfig                     |   1 +
 include/dt-bindings/pinctrl/dra.h               |   3 +
 15 files changed, 1142 insertions(+), 47 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi
 create mode 100644 arch/arm/boot/dts/dra74x-mmc-iodelay.dtsi

-- 
2.11.0
