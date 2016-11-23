From: hs.liao@mediatek.com (HS Liao)
Date: Wed, 23 Nov 2016 16:38:59 +0800
Subject: [PATCH v17 0/4] Mediatek MT8173 CMDQ support
Message-ID: <1479890343-4979-1-git-send-email-hs.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

This is Mediatek MT8173 Command Queue(CMDQ) driver. The CMDQ is used
to help write registers with critical time limitation, such as
updating display configuration during the vblank. It controls Global
Command Engine (GCE) hardware to achieve this requirement.

These patches have a build dependency on top of v4.9-rc1.

Changes since v16:
 - merge suspend/resume patch into cmdq driver patch
 - merge power saving patch into cmdq driver patch
 - split cmdq mailbox controller and cmdq helper into two different patches

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
 drivers/mailbox/mtk-cmdq-mailbox.c                 | 632 +++++++++++++++++++++
 drivers/soc/mediatek/Kconfig                       |  11 +
 drivers/soc/mediatek/Makefile                      |   1 +
 drivers/soc/mediatek/mtk-cmdq-helper.c             | 310 ++++++++++
 include/linux/mailbox/mtk-cmdq-mailbox.h           |  75 +++
 include/linux/soc/mediatek/mtk-cmdq.h              | 174 ++++++
 10 files changed, 1268 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt
 create mode 100644 drivers/mailbox/mtk-cmdq-mailbox.c
 create mode 100644 drivers/soc/mediatek/mtk-cmdq-helper.c
 create mode 100644 include/linux/mailbox/mtk-cmdq-mailbox.h
 create mode 100644 include/linux/soc/mediatek/mtk-cmdq.h

-- 
1.9.1
