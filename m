From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 18 Jul 2012 12:00:37 +0530
Subject: [PATCH v2 0/2] omap: add ocp2scp as a bus driver
Message-ID: <1342593039-7728-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is done as a preparatory step for adding phy drivers
for dwc3 and musb.

This series adds a new driver for ocp2scp (only dt) to which phy
drivers are connected.

Since currently there is no generic way to create a child device along
with doing a pm_runtime_enable (the exact requirement for ocp2scp), I'm
creating a separate driver for ocp2scp.

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

 .../devicetree/bindings/bus/omap-ocp2scp.txt       |   10 ++
 arch/arm/boot/dts/omap4.dtsi                       |    8 ++
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    2 +
 drivers/bus/Kconfig                                |   15 +++
 drivers/bus/Makefile                               |    5 +
 drivers/bus/omap-ocp2scp.c                         |   98 ++++++++++++++++++++
 7 files changed, 140 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/omap-ocp2scp.txt
 create mode 100644 drivers/bus/Kconfig
 create mode 100644 drivers/bus/Makefile
 create mode 100644 drivers/bus/omap-ocp2scp.c

-- 
1.7.5.4
