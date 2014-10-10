From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Sat, 11 Oct 2014 04:10:43 +0530
Subject: [PATCH V4 0/6] ARM64: Add support for FSL's LS2085A SoC
Message-ID: <1412980849-21318-1-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds the support for FSL's LS2085A SoC which is based on
ARMv8 architecture.

This patchset also has patches which address DT compatible strings for
nodes which appear un-documented.

The enable-method for the CPU nodes is left for the bootloader (u-boot or UEFI)
to patch-up which is expected to be PSCI v0.2

This patchset has been tested with the following patches which add PSCI
v0.2 support in ARMv8 u-boot:
http://patchwork.ozlabs.org/patch/383556/
http://patchwork.ozlabs.org/patch/383555/
http://patchwork.ozlabs.org/patch/383557/
http://patchwork.ozlabs.org/patch/383558/
http://patchwork.ozlabs.org/patch/383559/
http://patchwork.ozlabs.org/patch/383560/
http://patchwork.ozlabs.org/patch/383561/
http://patchwork.ozlabs.org/patch/383562/

Rebased against v3.17-rc7

Changes from v3:
----------------
* Addressed review comments:
	- Added comment to CPU node that enable-method is expected to be
	  PSCI v0.2
	- Added Dual X11 + GPLv2 Licenses to the DTS and DTSI files
	  (using sun4i DTS patches as a reference. See [1])

[1] https://patchwork.ozlabs.org/patch/385246/

Bhupesh Sharma (6):
  Documentation: DT: Add bindings for FSL NS16550A UART
  Documentation: DT: Add entry for FSL LS2085A SoC and Simulator model
  Documentation: DT: Add entry for FSL Management Complex
  arm64: Add DTS support for FSL's LS2085A SoC
  arm64: dts/Makefile: Add support for FSL's LS2085A simulator model
  arm64: Add support for FSL's LS2085A SoC in Kconfig and defconfig

 Documentation/devicetree/bindings/arm/fsl.txt      |    8 +
 .../devicetree/bindings/misc/fsl,qoriq-mc.txt      |   40 +++++
 .../devicetree/bindings/serial/of-serial.txt       |   12 ++
 arch/arm64/Kconfig                                 |    5 +
 arch/arm64/boot/dts/Makefile                       |    1 +
 arch/arm64/boot/dts/fsl-ls2085a-simu.dts           |   67 ++++++++
 arch/arm64/boot/dts/fsl-ls2085a.dtsi               |  164 ++++++++++++++++++++
 arch/arm64/configs/defconfig                       |    1 +
 8 files changed, 298 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
 create mode 100644 arch/arm64/boot/dts/fsl-ls2085a-simu.dts
 create mode 100644 arch/arm64/boot/dts/fsl-ls2085a.dtsi

-- 
1.7.9.5
