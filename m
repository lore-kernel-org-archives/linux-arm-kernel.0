From: kbeldan@baylibre.com (Karl Beldan)
Date: Tue,  9 Aug 2016 17:15:14 +0000
Subject: [PATCH 0/4] Add DT support for NAND to LCDK
Message-ID: <20160809171518.22690-1-kbeldan@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This does not use the same way the current da8xx boards do, instead
it is using the more generic and DT friendly memory driver ti-aemif.
I can do the same for the da850-evm and retire the dts nandcs3 instances.

Karl Beldan (4):
  memory: ti-aemif: Get a named clock rather than an unnamed one
  ARM: dts: da850: Add an aemif node
  ARM: dts: da850-lcdk: Add NAND to DT
  ARM: davinci_all_defconfig: Enable AEMIF as a module

 arch/arm/boot/dts/da850-lcdk.dts       | 108 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/da850.dtsi           |  10 +++
 arch/arm/configs/davinci_all_defconfig |   2 +
 drivers/memory/ti-aemif.c              |   2 +-
 4 files changed, 121 insertions(+), 1 deletion(-)

-- 
2.9.2
