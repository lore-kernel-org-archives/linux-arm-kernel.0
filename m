From: alexandre.torgue@gmail.com (Alexandre TORGUE)
Date: Mon, 29 Feb 2016 17:29:33 +0100
Subject: [PATCH 0/3] Enable Ethernet on STM32F429 EVAL board
Message-ID: <1456763376-21457-1-git-send-email-alexandre.torgue@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds Ethernet support on STM32F429 SOC and enable it on Eval
board:
 -Add Ethernet node in SOC file:
  -Define MII mode pinctrl
  -use Mixed burst and PBL 8
 -Add system config node for glue.
 -Enable Ethernet for Eval board:
  -mii mode
  -connected to a PHY through MDIO.

Note, this series follow the series which adds glue and update stmmac driver:

https://lkml.org/lkml/2016/2/26/329

Best regards.

Alex

Alexandre TORGUE (3):
  ARM: dts: stm32f429: Add system config bank node
  ARM: dts: stm32f429: Add Ethernet support
  ARM: dts: stm32f429: Enable Ethernet on Eval board

 arch/arm/boot/dts/stm32429i-eval.dts | 15 ++++++++++++++
 arch/arm/boot/dts/stm32f429.dtsi     | 40 ++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

-- 
1.9.1
