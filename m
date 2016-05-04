From: hs.liao@mediatek.com (HS Liao)
Date: Wed, 4 May 2016 20:32:13 +0800
Subject: [RFC v5 0/4] Mediatek MT8173 CMDQ support
Message-ID: <1462365137-715-1-git-send-email-hs.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

This is Mediatek MT8173 Command Queue(CMDQ) driver. The CMDQ is used
to help read/write registers with critical time limitation, such as
updating display configuration during the vblank. It controls Global
Command Engine (GCE) hardware to achieve this requirement.

These patches have a build dependency on top of v4.6-rc1.

Changes since v4:
 - fix bug of kmem_cache usage
 - print more meaningful log in suspend/resume flow
 - cascade all tasks into one vsync for display
 - merge cmdq_handle_done() and cmdq_handle_done_internal()
 - remove TASK_STATE_START_ERROR and its related flow
 - merge cmdq_rec_append_write() into cmdq_rec_append_command()
 - simplify some functions, such as cmdq_task_insert_into_thread(),
   cmdq_remove(), cmdq_task_acquire(), and cmdq_rec_append_command()
 - refine in program comments

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
 drivers/soc/mediatek/mtk-cmdq.c                    | 1708 ++++++++++++++++++++
 include/soc/mediatek/cmdq.h                        |  197 +++
 6 files changed, 1958 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/gce.txt
 create mode 100644 drivers/soc/mediatek/mtk-cmdq.c
 create mode 100644 include/soc/mediatek/cmdq.h

-- 
1.9.1
