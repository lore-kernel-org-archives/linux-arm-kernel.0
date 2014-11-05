From: flora.fu@mediatek.com (Flora Fu)
Date: Wed, 5 Nov 2014 22:21:29 +0800
Subject: [PATCH v3 0/3] Add Reset Controller for MediaTek SoC 
Message-ID: <1415197292-10546-1-git-send-email-flora.fu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
The patch is based on https://lkml.org/lkml/2014/5/27/422

Changes since v2
================
- Correct #size-cell to be 1.
- Add header file "mt8135-resets.h" for supported resets in MT8135.

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

 .../devicetree/bindings/reset/mediatek,reset.txt   |  50 ++++++++
 arch/arm/boot/dts/mt8135.dtsi                      |  27 +++++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-mtk.c                          | 131 +++++++++++++++++++++
 .../dt-bindings/reset-controller/mt8135-resets.h   |  64 ++++++++++
 5 files changed, 273 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/mediatek,reset.txt
 create mode 100644 drivers/reset/reset-mtk.c
 create mode 100644 include/dt-bindings/reset-controller/mt8135-resets.h

--
1.8.1.1.dirty
