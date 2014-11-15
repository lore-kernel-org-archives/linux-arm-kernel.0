From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Sat, 15 Nov 2014 16:16:25 +0530
Subject: [PATCH v5 0/6] ARM64: Add support for FSL's LS2085A SoC
Message-ID: <1416048391-7557-1-git-send-email-bhupesh.sharma@freescale.com>
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

Rebased against v3.18-rc4

Changes from v4:
----------------
* Addressed review comments:
	- Multi-line comment style fix.
	- Rebasing related changes.
	- Added Mark's Acked-by for patch 1/6
* Note that optional GIC-500 regs like GICC, GICH and GICV are currently
  not tested and hence are not part of the DTS patch.

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
 arch/arm64/boot/dts/fsl-ls2085a-simu.dts           |   65 ++++++++
 arch/arm64/boot/dts/fsl-ls2085a.dtsi               |  163 ++++++++++++++++++++
 arch/arm64/configs/defconfig                       |    1 +
 8 files changed, 295 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
 create mode 100644 arch/arm64/boot/dts/fsl-ls2085a-simu.dts
 create mode 100644 arch/arm64/boot/dts/fsl-ls2085a.dtsi

-- 
1.7.9.5
