From: houlong.wei@mediatek.com (Houlong Wei)
Date: Thu, 29 Nov 2018 11:37:07 +0800
Subject: [PATCH v27 0/2] MediaTek MT8173 CMDQ support
Message-ID: <1543462629-32746-1-git-send-email-houlong.wei@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is Mediatek MT8173 Command Queue(CMDQ) driver. The CMDQ is used
to help write registers with critical time limitation, such as
updating display configuration during the vblank. It controls Global
Command Engine (GCE) hardware to achieve this requirement.

Changes since v26:
 -rebase on v4.20-rc1
 -add comment to explain why cmdq_buf_size is increased in case of
  appending command failure
Changes since v25:
 -Replace WARN_ON() with WARN_ONCE() and add debug information.
Changes since v24:
 -move WARN_ON() into cmdq_pkt_append_command() from outside
Changes since v23:
 -rebase on v4.19-rc1
 -revise return value of cmdq_mbox_create()
 -revise cmdq_pkt_create()
 -add MODULE_LICENSE() for mtk-cmdq-helper.c
 -adjust functions order in mtk-cmdq.h
Changes since v22:
 -remove properties 'timeout' and 'thread-num' from device tree
 -move timer from CMDQ driver to CMDQ helper
 -move dma unmap from CMDQ driver to CMDQ helper
 -config thread number in CMDQ match table
 -remove reallocate mechanism and let client specify the cmdq buffer size
 -let client specify the timeout time
Changes since v21:
 -rebase on v4.18-rc1
 -remove subsys code and event id definition from mtk-cmdq-helper.c
 -add mt8173-gce.h to define the subsys code and envent id
Changes since v20:
 -rebase on v4.15-rc1
 -move dma_map_single outside of spinlock
Changes since v19:
 -rebase to v4.10-rc2

Houlong Wei (2):
  arm64: dts: mt8173: Add GCE node
  soc: mediatek: Add Mediatek CMDQ helper

 arch/arm64/boot/dts/mediatek/mt8173.dtsi |  10 +
 drivers/soc/mediatek/Kconfig             |  12 +
 drivers/soc/mediatek/Makefile            |   1 +
 drivers/soc/mediatek/mtk-cmdq-helper.c   | 300 +++++++++++++++++++++++
 include/linux/soc/mediatek/mtk-cmdq.h    | 133 ++++++++++
 5 files changed, 456 insertions(+)
 create mode 100644 drivers/soc/mediatek/mtk-cmdq-helper.c
 create mode 100644 include/linux/soc/mediatek/mtk-cmdq.h

-- 
2.19.1
