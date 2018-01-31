From: houlong.wei@mediatek.com (houlong.wei at mediatek.com)
Date: Wed, 31 Jan 2018 15:28:09 +0800
Subject: [PATCH v21 0/4] Mediatek MT8173 CMDQ support
Message-ID: <1517383693-25591-1-git-send-email-houlong.wei@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is Mediatek MT8173 Command Queue(CMDQ) driver. The CMDQ is used
to help write registers with critical time limitation, such as
updating display configuration during the vblank. It controls Global
Command Engine (GCE) hardware to achieve this requirement.
 
Changes since v20:
 -rebase to v4.15-rc1
 -move dma_map_single outside of spinlock
Changes since v19:
 -rebase to v4.10-rc2

hs.liao at mediatek.com (4):
  dt-bindings: soc: Add documentation for the MediaTek GCE unit
  mailbox: mediatek: Add Mediatek CMDQ driver
  arm64: dts: mt8173: Add GCE node
  soc: mediatek: Add Mediatek CMDQ helper

 .../devicetree/bindings/mailbox/mtk-gce.txt        |   43 ++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |   10 +
 drivers/mailbox/Kconfig                            |   10 +
 drivers/mailbox/Makefile                           |    2 +
 drivers/mailbox/mtk-cmdq-mailbox.c                 |  594 ++++++++++++++++++++
 drivers/soc/mediatek/Kconfig                       |   12 +
 drivers/soc/mediatek/Makefile                      |    1 +
 drivers/soc/mediatek/mtk-cmdq-helper.c             |  322 +++++++++++
 include/linux/mailbox/mtk-cmdq-mailbox.h           |   77 +++
 include/linux/soc/mediatek/mtk-cmdq.h              |  174 ++++++
 10 files changed, 1245 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt
 create mode 100644 drivers/mailbox/mtk-cmdq-mailbox.c
 create mode 100644 drivers/soc/mediatek/mtk-cmdq-helper.c
 create mode 100644 include/linux/mailbox/mtk-cmdq-mailbox.h
 create mode 100644 include/linux/soc/mediatek/mtk-cmdq.h

-- 
1.7.9.5 
