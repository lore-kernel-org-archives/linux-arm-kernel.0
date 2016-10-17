From: hs.liao@mediatek.com (HS Liao)
Date: Mon, 17 Oct 2016 18:11:53 +0800
Subject: [PATCH v15 0/4] Mediatek MT8173 CMDQ support
Message-ID: <1476699117-3001-1-git-send-email-hs.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

This is Mediatek MT8173 Command Queue(CMDQ) driver. The CMDQ is used
to help write registers with critical time limitation, such as
updating display configuration during the vblank. It controls Global
Command Engine (GCE) hardware to achieve this requirement.

These patches have a build dependency on top of v4.9-rc1.

Changes since v14:
 - split driver into mtk-cmdq-mailbox and mtk-cmdq-helper
 - split cmdq_task into cmdq_pkt for client and cmdq_task for controller
 - remove mailbox_controller.h from mtk-cmdq.h
 - replace msleep() by schedule()
 - replace irq_of_parse_and_map() by platform_get_irq()
 - remove .owner = THIS_MODULE
 - rebase to Linux v4.9-rc1

Best regards,
HS Liao

HS Liao (4):
  dt-bindings: soc: Add documentation for the MediaTek GCE unit
  CMDQ: Mediatek CMDQ driver
  arm64: dts: mt8173: Add GCE node
  CMDQ: save energy

 .../devicetree/bindings/mailbox/mtk-gce.txt        |  43 ++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  10 +
 drivers/mailbox/Kconfig                            |  10 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/mtk-cmdq-mailbox.c                 | 634 +++++++++++++++++++++
 drivers/soc/mediatek/Kconfig                       |  11 +
 drivers/soc/mediatek/Makefile                      |   1 +
 drivers/soc/mediatek/mtk-cmdq-helper.c             | 310 ++++++++++
 include/linux/mailbox/mtk-cmdq-mailbox.h           |  67 +++
 include/linux/soc/mediatek/mtk-cmdq.h              | 182 ++++++
 10 files changed, 1270 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt
 create mode 100644 drivers/mailbox/mtk-cmdq-mailbox.c
 create mode 100644 drivers/soc/mediatek/mtk-cmdq-helper.c
 create mode 100644 include/linux/mailbox/mtk-cmdq-mailbox.h
 create mode 100644 include/linux/soc/mediatek/mtk-cmdq.h

-- 
1.9.1
