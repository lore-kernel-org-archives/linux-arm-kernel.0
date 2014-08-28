From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Thu, 28 Aug 2014 15:25:00 +0530
Subject: [PATCH V2 0/6] ARM64: Add support for FSL's LS2085A SoC
Message-ID: <1409219706-14843-1-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds the support for FSL's LS2085A SoC which is based on
ARMv8 architecture.

This patchset also has patches which addresses DT compatible strings for
nodes which appear un-documented.

In this version, the enable-method for the CPU nodes is left for the
bootloader (u-boot or UEFI) to patch-up. This DTS has been tested for
PSCI v0.2 CPU_ON method (and corresponding secondary boot) using the
following ARMv8 u-boot patches:

http://patchwork.ozlabs.org/patch/383556/
http://patchwork.ozlabs.org/patch/383555/
http://patchwork.ozlabs.org/patch/383557/
http://patchwork.ozlabs.org/patch/383558/
http://patchwork.ozlabs.org/patch/383559/
http://patchwork.ozlabs.org/patch/383560/
http://patchwork.ozlabs.org/patch/383561/
http://patchwork.ozlabs.org/patch/383562/

Changes from v1:
----------------
* Addressed review comments:
	- PSCI v0.2 enable method for CPU patched by corresponding
	  u-boot patches for ARMv8 (which are referred-to above):
	- Moved the NS16550 DT documentation to a new location:
		devicetree/bindings/serial/of-serial.txt
	- Minor nit-pick in FSL Management Complex DT node in regs
	  section.
	- Minor nit-pick in smsc ethernet DT node.
	- Removed GICv3-ITS node from the DTS.
	- Addressed Virtual timer PPI interrupt number and some other
	  minor nit-picks.

Bhupesh Sharma (6):
  Documentation: DT: Add bindings for FSL NS16550A UART
  Documentation: DT: Add entry for FSL LS2085A SoC and Simulator model
  Documentation: DT: Add entry for FSL Management Complex
  arm64: Add DTS support for FSL's LS2085A SoC
  arm64: dts/Makefile: Add support for FSL's LS2085A simulator model
  arm64: Add support for FSL's LS2085A SoC in Kconfig and defconfig

 Documentation/devicetree/bindings/arm/fsl.txt      |    8 ++
 .../devicetree/bindings/misc/fsl,qoriq-mc.txt      |   40 +++++++
 .../devicetree/bindings/serial/of-serial.txt       |   12 ++
 arch/arm64/Kconfig                                 |    5 +
 arch/arm64/boot/dts/Makefile                       |    1 +
 arch/arm64/boot/dts/fsl-ls2085a-simu.dts           |   26 +++++
 arch/arm64/boot/dts/fsl-ls2085a.dtsi               |  120 ++++++++++++++++++++
 arch/arm64/configs/defconfig                       |    1 +
 8 files changed, 213 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
 create mode 100644 arch/arm64/boot/dts/fsl-ls2085a-simu.dts
 create mode 100644 arch/arm64/boot/dts/fsl-ls2085a.dtsi

-- 
1.7.9.5
