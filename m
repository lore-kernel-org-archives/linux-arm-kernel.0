From: hs.liao@mediatek.com (HS Liao)
Date: Wed, 24 Aug 2016 11:27:28 +0800
Subject: [PATCH v13 0/4] Mediatek MT8173 CMDQ support
Message-ID: <1472009252-1074-1-git-send-email-hs.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

This is Mediatek MT8173 Command Queue(CMDQ) driver. The CMDQ is used
to help write registers with critical time limitation, such as
updating display configuration during the vblank. It controls Global
Command Engine (GCE) hardware to achieve this requirement.

These patches have a build dependency on top of v4.8-rc1.

Changes since v12:
 - remove mediatek,gce from device tree

Best regards,
HS Liao

HS Liao (4):
  dt-bindings: soc: Add documentation for the MediaTek GCE unit
  CMDQ: Mediatek CMDQ driver
  arm64: dts: mt8173: Add GCE node
  CMDQ: save more energy in idle

 .../devicetree/bindings/soc/mediatek/gce.txt       |  44 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  10 +
 drivers/soc/mediatek/Kconfig                       |  11 +
 drivers/soc/mediatek/Makefile                      |   1 +
 drivers/soc/mediatek/mtk-cmdq.c                    | 983 +++++++++++++++++++++
 include/soc/mediatek/cmdq.h                        | 180 ++++
 6 files changed, 1229 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/gce.txt
 create mode 100644 drivers/soc/mediatek/mtk-cmdq.c
 create mode 100644 include/soc/mediatek/cmdq.h

-- 
1.9.1
