From: hs.liao@mediatek.com (hs.liao at mediatek.com)
Date: Wed, 20 Jan 2016 13:14:37 +0800
Subject: [RFC 0/3] MT8173 CMDQ support
Message-ID: <1453266881-16849-1-git-send-email-hs.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

This is the first version to add Mediatek MT8173 Command Queue(CMDQ)
support. The CMDQ is used to help read/write registers with critical
time limitation, such as updating display configuration during the
vblank. It controls Global Command Engine (GCE) hardware to achieve
this requirement.

These patches have a build dependency on top of v4.4-rc1.

Best regards,
HS Liao

HS Liao (3):
  dt-bindings: soc: Add documentation for the MediaTek GCE unit
  arm64: dts: mt8173: Add GCE node
  CMDQ: Mediatek CMDQ driver

 .../devicetree/bindings/soc/mediatek/gce.txt       |   33 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |    8 +
 drivers/soc/mediatek/Kconfig                       |   10 +
 drivers/soc/mediatek/Makefile                      |    1 +
 drivers/soc/mediatek/mtk-cmdq.c                    | 3532 ++++++++++++++++++++
 include/soc/mediatek/cmdq.h                        |  225 ++
 6 files changed, 3809 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/gce.txt
 create mode 100644 drivers/soc/mediatek/mtk-cmdq.c
 create mode 100644 include/soc/mediatek/cmdq.h

-- 
1.7.9.5
