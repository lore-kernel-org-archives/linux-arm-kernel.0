From: flora.fu@mediatek.com (Flora Fu)
Date: Fri, 26 Dec 2014 17:05:48 +0800
Subject: [PATCH v4 0/3] Add Reset Controller for MediaTek SoC 
Message-ID: <1419584751-18149-1-git-send-email-flora.fu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
This driver implements the reset controller for MediaTek SoC.
It adds support for MT8135 and MT8173 SoC in the patch set.
The reset controller uses syscon as its regmap and adopts syscon RFC in https://lkml.org/lkml/2014/11/3/134.

This driver is based on 3.19-rc1.

Changes since v3
================
1. Merge patch set by 3.19-rc1.
2. Add header file "mt8173-resets.h" for supported resets in MT8173.

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

Flora Fu (3):
  reset: mediatek: Add Reset Controller for MediaTek SoC
  dt-bindings: Add Reset Controller for MediaTek SoC
  arm: dts: mt8135: Add Reset Controller for MediaTek SoC

 .../devicetree/bindings/reset/mediatek,reset.txt   |  52 +++++++++
 arch/arm/boot/dts/mt8135.dtsi                      |  29 +++++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-mtk.c                          | 130 +++++++++++++++++++++
 .../dt-bindings/reset-controller/mt8135-resets.h   |  64 ++++++++++
 .../dt-bindings/reset-controller/mt8173-resets.h   |  63 ++++++++++
 6 files changed, 339 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/mediatek,reset.txt
 create mode 100644 drivers/reset/reset-mtk.c
 create mode 100644 include/dt-bindings/reset-controller/mt8135-resets.h
 create mode 100644 include/dt-bindings/reset-controller/mt8173-resets.h

--
1.8.1.1.dirty
