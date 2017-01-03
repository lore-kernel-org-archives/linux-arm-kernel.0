From: hs.liao@mediatek.com (HS Liao)
Date: Tue, 3 Jan 2017 11:05:47 +0800
Subject: [PATCH v19 0/4] Mediatek MT8173 CMDQ support
Message-ID: <1483412751-28690-1-git-send-email-hs.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

This is Mediatek MT8173 Command Queue(CMDQ) driver. The CMDQ is used
to help write registers with critical time limitation, such as
updating display configuration during the vblank. It controls Global
Command Engine (GCE) hardware to achieve this requirement.

These patches have a build dependency on top of v4.10-rc1.

Changes since v18:
 - add "select MAILBOX" into CMDQ helper
 - remove power saving part to prevent a potential bug

Best regards,
HS Liao

HS Liao (4):
  dt-bindings: soc: Add documentation for the MediaTek GCE unit
  mailbox: mediatek: Add Mediatek CMDQ driver
  arm64: dts: mt8173: Add GCE node
  soc: mediatek: Add Mediatek CMDQ helper

 .../devicetree/bindings/mailbox/mtk-gce.txt        |  43 ++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  10 +
 drivers/mailbox/Kconfig                            |  10 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/mtk-cmdq-mailbox.c                 | 596 +++++++++++++++++++++
 drivers/soc/mediatek/Kconfig                       |  12 +
 drivers/soc/mediatek/Makefile                      |   1 +
 drivers/soc/mediatek/mtk-cmdq-helper.c             | 310 +++++++++++
 include/linux/mailbox/mtk-cmdq-mailbox.h           |  75 +++
 include/linux/soc/mediatek/mtk-cmdq.h              | 174 ++++++
 10 files changed, 1233 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt
 create mode 100644 drivers/mailbox/mtk-cmdq-mailbox.c
 create mode 100644 drivers/soc/mediatek/mtk-cmdq-helper.c
 create mode 100644 include/linux/mailbox/mtk-cmdq-mailbox.h
 create mode 100644 include/linux/soc/mediatek/mtk-cmdq.h

-- 
1.9.1
