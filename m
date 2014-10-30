From: flora.fu@mediatek.com (flora.fu at mediatek.com)
Date: Thu, 30 Oct 2014 11:12:10 +0800
Subject: [PATCH 0/3] Add Reset Controller for MediaTek SoC 
Message-ID: <1414638733-10080-1-git-send-email-flora.fu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver is based on 3.18-rc1. . 
This series adds support generic reset controller for MediaTek SoC.
Reset registers contain several bytes and each bit is able to reset individual module in SoC.
 - Patch 1/3: Add a driver in reset controller
 - Patch 2/3: Add device tree bindings
 - Patch 3/3: Add reset controller to MT8135 board dts
   
 Flora Fu (3):
  ARM: mediatek: Add Reset Controller for MediaTek SoC
  dt-bindings: Add Reset Controller for MediaTek SoC
  ARM: dts: mt8135: Add Reset Controller for MediaTek SoC

 .../devicetree/bindings/reset/mediatek,reset.txt   |  37 +++++
 arch/arm/boot/dts/mt8135.dtsi                      |  22 +++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-mtk.c                          | 149 +++++++++++++++++++++
 4 files changed, 209 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/mediatek,reset.txt
 create mode 100644 drivers/reset/reset-mtk.c

--
1.8.1.1.dirty
