From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 22 Aug 2012 14:10:01 +0530
Subject: [RESEND PATCH v4 0/2] omap: add ocp2scp as a bus driver
Message-ID: <1345624803-16379-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series has been lying here for long. If no one has any
comments on this patch series, can someone pick it up?

This patch series is done as a preparatory step for adding phy drivers
for dwc3 and musb.

This series adds a new driver for ocp2scp (only dt) to which phy
drivers are connected.

Since currently there is no generic way to create a child device along
with doing a pm_runtime_enable (the exact requirement for ocp2scp), I'm
creating a separate driver for ocp2scp.

Changes from v3:
No functional changes. Fixed few comments on filling *module* details.

Changes from v2:
Fixed Felipe's comments to avoid using arch_initcall and make dependent
drivers return -EPROBE_DEFER case this isn't ready yet.

Changes from v1:
Fixed Sergei's comments to remove the address in the node name of ocp2scp
since the ocp2scp node doesn't have a reg property.

Changes from [RFC PATCH v2 0/2] omap: add ocp2scp as a misc driver:
Created a new folder drivers/bus and moved ocp2scp driver from misc to
drivers/bus.

This patch was developed and tested on
git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git

Kishon Vijay Abraham I (2):
  drivers: bus: add a new driver for omap-ocp2scp
  arm/dts: omap4: Add ocp2scp data

 .../devicetree/bindings/bus/omap-ocp2scp.txt       |   10 +++
 arch/arm/boot/dts/omap4.dtsi                       |    8 ++
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    2 +
 drivers/bus/Kconfig                                |   15 ++++
 drivers/bus/Makefile                               |    5 ++
 drivers/bus/omap-ocp2scp.c                         |   88 ++++++++++++++++++++
 7 files changed, 130 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/omap-ocp2scp.txt
 create mode 100644 drivers/bus/Kconfig
 create mode 100644 drivers/bus/Makefile
 create mode 100644 drivers/bus/omap-ocp2scp.c

-- 
1.7.9.5
