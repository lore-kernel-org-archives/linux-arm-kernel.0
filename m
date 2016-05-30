From: hs.liao@mediatek.com (HS Liao)
Date: Mon, 30 May 2016 11:19:54 +0800
Subject: [PATCH v8 0/3] Mediatek MT8173 CMDQ support
Message-ID: <1464578397-29743-1-git-send-email-hs.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

This is Mediatek MT8173 Command Queue(CMDQ) driver. The CMDQ is used
to help read/write registers with critical time limitation, such as
updating display configuration during the vblank. It controls Global
Command Engine (GCE) hardware to achieve this requirement.

These patches have a build dependency on top of v4.6-rc1.

Changes since v7:
 - fix one v6 bug and one v7 bug, which are due to rewriting for coding style
 - use flushing work queue instead of killing active tasks in suspend and
   merge suspend/resume protection patch into CMDQ driver patch
 - refine some code accroding to comments for v7

Best regards,
HS Liao

HS Liao (3):
  dt-bindings: soc: Add documentation for the MediaTek GCE unit
  CMDQ: Mediatek CMDQ driver
  arm64: dts: mt8173: Add GCE node

 .../devicetree/bindings/soc/mediatek/gce.txt       |  34 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |   8 +
 drivers/soc/mediatek/Kconfig                       |  10 +
 drivers/soc/mediatek/Makefile                      |   1 +
 drivers/soc/mediatek/mtk-cmdq.c                    | 943 +++++++++++++++++++++
 include/soc/mediatek/cmdq.h                        | 197 +++++
 6 files changed, 1193 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/gce.txt
 create mode 100644 drivers/soc/mediatek/mtk-cmdq.c
 create mode 100644 include/soc/mediatek/cmdq.h

-- 
1.9.1
