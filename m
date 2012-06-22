From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 22 Jun 2012 18:45:40 +0530
Subject: [RFC PATCH v2 0/2] omap: add ocp2scp as a misc driver
Message-ID: <1340370942-23201-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is done as a preparatory step for adding phy drivers
for dwc3 and musb.

This series adds a new driver for ocp2scp (only dt) to which phy
drivers are connected.

Since currently there is no generic way to create a child device along
with doing a pm_runtime_enable (the exact requirement for ocp2scp), i'm
sending this second rfc patch with only dt support. If we can figure out
a way to do that generically this patch series can be dropped and I'll
send a patch only for adding dt data.

*arm: omap: hwmod: make *phy_48m* as the main_clk of ocp2scp* and
*arm: omap: remove ocp2scp_usb_phy_ick clock node* patches are removed
from the series as Benoit is planning to take it up in his series.

This series was developed on
http://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-next

and [RFC PATCH 00/11] OMAP System Control Module (There is no direct
dependencies with this patch series).

However to test this patch series, the following patch series is needed
[PATCH v7 0/3] usb: multi-phy support
[PATCH v3 0/5] usb: musb: cleanup
[RFC PATCH 00/11] OMAP System Control Module
[RFC PATCH 00/10] omap: musb: Add device tree support (To be sent)

Kishon Vijay Abraham I (2):
  drivers: misc: omap: add a new driver for ocp2scp
  arm/dts: omap4: Add ocp2scp data

 .../devicetree/bindings/misc/omap-ocp2scp.txt      |    9 ++
 arch/arm/boot/dts/omap4.dtsi                       |    7 ++
 drivers/misc/Kconfig                               |    8 ++
 drivers/misc/Makefile                              |    1 +
 drivers/misc/omap-ocp2scp.c                        |   96 ++++++++++++++++++++
 5 files changed, 121 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/omap-ocp2scp.txt
 create mode 100644 drivers/misc/omap-ocp2scp.c

-- 
1.7.5.4
