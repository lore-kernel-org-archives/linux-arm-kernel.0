From: hs.liao@mediatek.com (HS Liao)
Date: Mon, 23 May 2016 20:23:06 +0800
Subject: [PATCH v7 0/4] Mediatek MT8173 CMDQ support
Message-ID: <1464006190-344-1-git-send-email-hs.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

This is Mediatek MT8173 Command Queue(CMDQ) driver. The CMDQ is used
to help read/write registers with critical time limitation, such as
updating display configuration during the vblank. It controls Global
Command Engine (GCE) hardware to achieve this requirement.

These patches have a build dependency on top of v4.6-rc1.

Changes since v6:
 - remove task waiting list
 - remove cmdq_command
 - use kzalloc/kfree instead of kmem_cache
 - use u64* instead of u32* if suitable
 - shrink some code

Best regards,
HS Liao

HS Liao (4):
  dt-bindings: soc: Add documentation for the MediaTek GCE unit
  CMDQ: Mediatek CMDQ driver
  arm64: dts: mt8173: Add GCE node
  CMDQ: suspend/resume protection

 .../devicetree/bindings/soc/mediatek/gce.txt       |   34 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |    8 +
 drivers/soc/mediatek/Kconfig                       |   10 +
 drivers/soc/mediatek/Makefile                      |    1 +
 drivers/soc/mediatek/mtk-cmdq.c                    | 1062 ++++++++++++++++++++
 include/soc/mediatek/cmdq.h                        |  197 ++++
 6 files changed, 1312 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/gce.txt
 create mode 100644 drivers/soc/mediatek/mtk-cmdq.c
 create mode 100644 include/soc/mediatek/cmdq.h

-- 
1.9.1
