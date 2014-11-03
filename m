From: flora.fu@mediatek.com (Flora Fu)
Date: Mon, 3 Nov 2014 17:02:48 +0800
Subject: [PATCH v2 0/3] Add Reset Controller for MediaTek SoC
Message-ID: <1415005371-4323-1-git-send-email-flora.fu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
The patch modification is base on https://lkml.org/lkml/2014/5/27/422

Changes since v1
================
(1) Patch 1/3: Update reset controller driver's implementation. 
  - rename mt_ prefixes to the prefix mtk_
  - use module_platform_driver() macro for driver init.
  - clean up includes of header files.
  - reset controll is a child of syscon. Get regamp through its parent node.
  - rename data->size to data->num_regs. It is number of registers in syscon for reset usage. 
(2) Patch 2/3: update bindings document according to new dts layout of reset-controller. 
(3) Patch 3/3: change reset-controller device node as child of syscon. 

This driver is based on 3.18-rc1.

Flora Fu (3):
  ARM: mediatek: Add Reset Controller for MediaTek SoC
  dt-bindings: Add Reset Controller for MediaTek SoC
  ARM: dts: mt8135: Add Reset Controller for MediaTek SoC

 .../devicetree/bindings/reset/mediatek,reset.txt   |  45 +++++++
 arch/arm/boot/dts/mt8135.dtsi                      |  26 ++++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-mtk.c                          | 131 +++++++++++++++++++++
 4 files changed, 203 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/mediatek,reset.txt
 create mode 100644 drivers/reset/reset-mtk.c

--
1.8.1.1.dirty
