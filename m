From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Fri, 6 Jan 2017 14:59:44 +0800
Subject: [PATCH 0/3] ARM: at91: fix cpuidle crash on SAMA5D4 Xplained board
Message-ID: <20170106065947.30631-1-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix cpuidle crash on SAMA5D4 Xplained board when enable
CONFIG_ARM_AT91_CPUIDLE. Because some SoCs have the L2 cache,
we should flush the L2 cache before entering the cpu idle.


Wenyou Yang (3):
  ARM: at91: flush the L2 cache before entering cpu idle
  doc: binding: add new compatible for SDRAM/DDR Controller
  ARM: dts: at91: use "atmel,sama5d4-ddramc" for ramc

 Documentation/devicetree/bindings/arm/atmel-at91.txt |  1 +
 arch/arm/boot/dts/sama5d2.dtsi                       |  2 +-
 arch/arm/boot/dts/sama5d4.dtsi                       |  2 +-
 arch/arm/mach-at91/pm.c                              | 19 +++++++++++++++++++
 drivers/memory/atmel-sdramc.c                        |  1 +
 5 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.11.0
