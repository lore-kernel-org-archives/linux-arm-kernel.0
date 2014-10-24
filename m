From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Fri, 24 Oct 2014 18:08:41 +0800
Subject: [PATCHv6 0/6] ARM: imx: Add Freescale LS1021A SoC and board support
Message-ID: <1414145327-23541-1-git-send-email-jingchang.lu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contain the support for Freescale LS1021A CPU and LS1021A-QDS
and LS1021A-TWR board.

The LS1021A SoC combines two ARM Cortex-A7 cores that have been optimized
for high reliability and pack the highest level of integration available
for sub-3W embedded communications processors and with a comprehensive
enablement model focused on ease of programmability.

The LS1021A SoC shares IPs with i.MX family, Vybrid family and Freescale
PowerPC platform. 

For the detail information about LS1021A SoC, please refer to the RM doc.

---
changes in v6:
 add dts patch description.
 remove '-' from QDS and TWR board dts name for consistence with u-boot.

changes in v5:
 remove unideal dts nodes for later add.
 add X11 license to dts files.

changes in v4:
 add "syscon" compatible to scfg and dcfg dts node.
 remove mxc_restart in the platform machine desc.
 remove dma_zone_size defination.

changes in v3:
 rewrite scfg and dcfg binding doc description.
 remove sai related node leaving to the driver support.

changes in v2:
 remove unused nodes.
 wakeup the secondary core by IPI call to u-boot standby procedure. 
 add dt-bindings for LS1021A SoC and platform gerenal configuration nodes.

----------------------------------------------------------------
Jingchang Lu (6):
	ARM: dts: Add SoC level device tree support for LS1021A
	ARM: dts: Add initial LS1021A QDS board dts support
	ARM: dts: Add initial LS1021A TWR board dts support
	dt-bindings: arm: add Freescale LS1021A SoC device tree binding
	ARM: imx: Add initial support for Freescale LS1021A
	ARM: imx: Add Freescale LS1021A SMP support

 Documentation/devicetree/bindings/arm/fsl.txt |  38 +++++
 arch/arm/boot/dts/Makefile                    |   2 +
 arch/arm/boot/dts/ls1021a.dtsi                | 408 ++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/ls1021aqds.dts              | 240 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/ls1021atwr.dts              | 127 ++++++++++++++++
 arch/arm/mach-imx/Kconfig                     |  14 ++
 arch/arm/mach-imx/Makefile                    |   4 +-
 arch/arm/mach-imx/common.h                    |   1 +
 arch/arm/mach-imx/mach-ls1021a.c              |  22 +++
 arch/arm/mach-imx/platsmp.c                   |  33 ++++
 10 files changed, 888 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/ls1021a.dtsi
 create mode 100644 arch/arm/boot/dts/ls1021aqds.dts
 create mode 100755 arch/arm/boot/dts/ls1021atwr.dts
 create mode 100644 arch/arm/mach-imx/mach-ls1021a.c
