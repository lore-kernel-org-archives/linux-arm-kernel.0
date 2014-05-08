From: sourav.poddar@ti.com (Sourav Poddar)
Date: Thu, 8 May 2014 11:30:03 +0530
Subject: [PATCHv2 0/5] AM437x: HDQ/1wire protocol
Message-ID: <1399528808-6920-1-git-send-email-sourav.poddar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for HDQ/1w protocol driver for
am43x epos evm where it can be used for measuring the
temperature of a slave device connected to a particular header.

Tested the patch series on AM437x, hdq master and slave devices are
getting registered and interrupts are getting triggered for break and tx
conditions. 

v1->v2:
cleaned up "hdq_disable_interrupt" api.

Sourav Poddar (5):
  drivers: w1: omap_hdq: cleanup and bug fixes.
  w1: omap_hdq: Add compatible property for omap hdq driver.
  arm: mach-omap2: selective device build from the platform code.
  arm: dts: am4372: Add hdq device tree data.
  arm: hwmod: am437x: Add hwmod data for hdq1w.

 .../devicetree/bindings/hdq1w/omap_hdq.txt         |   20 +++++
 arch/arm/boot/dts/am4372.dtsi                      |   10 +++
 arch/arm/boot/dts/am43x-epos-evm.dts               |   12 +++
 arch/arm/mach-omap2/hdq1w.c                        |    2 +
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |   36 ++++++++
 arch/arm/mach-omap2/prcm43xx.h                     |    1 +
 drivers/w1/masters/omap_hdq.c                      |   93 ++++++++++++++++----
 7 files changed, 157 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hdq1w/omap_hdq.txt

-- 
1.7.9.5
