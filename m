From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Sun, 25 Jan 2015 02:42:48 +0530
Subject: [RESEND PATCH v7 0/5] ARM64: Add support for FSL's LS2085A SoC
Message-ID: <1422133973-16460-1-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reposting this series as last time it was sent during the merge window

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

Rebased against cleanup/dts-subdirs branch of the arm-soc tree

Changes from v6:
----------------
* Rebased against cleanup/dts-subdirs branch of the arm-soc tree.
* As a result, [PATCH 4/6] and [PATCH 5/6] of the v6 series are squashed
  into one patch ([PATCH 4/5] of this series).

Note:
-----
Optional GIC-500 regs like GICC, GICH and GICV are currently
not tested and hence are not part of the DTS patch.

Please review and consider for merge.

Bhupesh Sharma (5):
  Documentation: DT: Add bindings for FSL NS16550A UART
  Documentation: DT: Add entry for FSL LS2085A SoC and Simulator model
  Documentation: DT: Add entry for FSL Management Complex
  arm64: Add DTS support for FSL's LS2085A SoC
  arm64: Add support for FSL's LS2085A SoC in Kconfig and defconfig

 Documentation/devicetree/bindings/arm/fsl.txt      |    8 +
 .../devicetree/bindings/misc/fsl,qoriq-mc.txt      |   40 +++++
 .../devicetree/bindings/serial/of-serial.txt       |   12 ++
 arch/arm64/Kconfig                                 |    5 +
 arch/arm64/boot/dts/Makefile                       |    1 +
 arch/arm64/boot/dts/{ => freescale}/Makefile       |    4 +-
 arch/arm64/boot/dts/freescale/fsl-ls2085a-simu.dts |   65 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi     |  163 ++++++++++++++++++++
 arch/arm64/configs/defconfig                       |    1 +
 9 files changed, 296 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
 copy arch/arm64/boot/dts/{ => freescale}/Makefile (54%)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2085a-simu.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi

-- 
1.7.9.5
