From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 14 Jan 2014 13:30:30 -0800
Subject: [PATCH v5 0/4] Krait L1/L2 EDAC driver
Message-ID: <1389735034-21430-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the Krait L1/L2 cache error detection
hardware. The first patch adds the Krait l2 indirection
register code. This patch is in need of an ACK from ARM folks.
The next two patches add the driver and the binding and 
the final patch hooks it all up by adding the device tree node.

I think Boris will pick up the first and third patches since they depend
on each other. The final dts change could go through arm-soc via davidb's tree
and the Documentation patch could go through the devicetree tree. Or patches 1
through 3 can go through Boris' tree.

Changes since v4:
 * Prefixed l2 accessors functions with krait_
 * Dropped first two patches as Boris says he picked them up

Changes since v3:
 * Fixed l1_irq handler to properly dereference dev_id

Changes since v2:
 * Picked up acks
 * s/an/a/ in DT binding

Stephen Boyd (4):
  ARM: Add Krait L2 register accessor functions
  devicetree: bindings: Document Krait CPU/L1 EDAC
  edac: Add support for Krait CPU cache error detection
  ARM: dts: msm: Add Krait CPU/L2 nodes

 Documentation/devicetree/bindings/arm/cpus.txt |  52 ++++
 arch/arm/boot/dts/qcom-msm8974.dtsi            |  41 +++
 arch/arm/common/Kconfig                        |   3 +
 arch/arm/common/Makefile                       |   1 +
 arch/arm/common/krait-l2-accessors.c           |  58 +++++
 arch/arm/include/asm/krait-l2-accessors.h      |  20 ++
 drivers/edac/Kconfig                           |   8 +
 drivers/edac/Makefile                          |   2 +
 drivers/edac/krait_edac.c                      | 346 +++++++++++++++++++++++++
 9 files changed, 531 insertions(+)
 create mode 100644 arch/arm/common/krait-l2-accessors.c
 create mode 100644 arch/arm/include/asm/krait-l2-accessors.h
 create mode 100644 drivers/edac/krait_edac.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
