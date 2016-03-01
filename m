From: hs.liao@mediatek.com (HS Liao)
Date: Tue, 1 Mar 2016 21:29:13 +0800
Subject: [RFC v2 0/3] Mediatek MT8173 CMDQ support
Message-ID: <1456838956-16153-1-git-send-email-hs.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

This is Mediatek MT8173 Command Queue(CMDQ) driver. The CMDQ is used
to help read/write registers with critical time limitation, such as
updating display configuration during the vblank. It controls Global
Command Engine (GCE) hardware to achieve this requirement.

These patches have a build dependency on top of v4.5-rc1.

Changes since v1:
 - update device tree binding doc
 - use void* for base address
 - use size_t for "size in bytes"
 - use cmdq_thread instead of thread id
 - use flags instead of scenarios
 - call cmdq_event_reset() in suitable places
 - use ktime instead of sched_clock
 - use struct device instead of struct platform_device if possible
 - rename recorder to record
 - correct some typos and remove some useless code

Best regards,
HS Liao

HS Liao (3):
  dt-bindings: soc: Add documentation for the MediaTek GCE unit
  arm64: dts: mt8173: Add GCE node
  CMDQ: Mediatek CMDQ driver

 .../devicetree/bindings/soc/mediatek/gce.txt       |   34 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |    8 +
 drivers/soc/mediatek/Kconfig                       |   10 +
 drivers/soc/mediatek/Makefile                      |    1 +
 drivers/soc/mediatek/mtk-cmdq.c                    | 2788 ++++++++++++++++++++
 include/soc/mediatek/cmdq.h                        |  211 ++
 6 files changed, 3052 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/gce.txt
 create mode 100644 drivers/soc/mediatek/mtk-cmdq.c
 create mode 100644 include/soc/mediatek/cmdq.h

-- 
1.9.1
