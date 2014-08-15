From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Fri, 15 Aug 2014 15:19:09 +0530
Subject: [PATCH 0/6] ARM64: Add support for FSL's LS2085A SoC
Message-ID: <1408096156-29772-1-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds the support for FSL 2085A SoC which is based on
ARMv8 architecture.

This patchset also has patches which addresses DT compatible string for
nodes which appear un-documented.

This patchset is dependent on the 'arm64: initial support for GICv3'
patches from Marc Zyngier and the related ITS patches:

- Refer to his GICv3 tree here:
  https://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm64/gicv3

Bhupesh Sharma (6):
  Documentation: DT: Add bindings for FSL NS16550A UART
  Documentation: DT: Add entry for FSL LS2085A SoC and Simulator model
  Documentation: DT: Add entry for FSL Management Complex
  arm64: Add DTS support for FSL's LS2085A SoC
  arm64: dts/Makefile: Add support for FSL's LS2085A simulator model
  arm64: Add support for FSL's LS2085A SoC in Kconfig and defconfig

 Documentation/devicetree/bindings/arm/fsl.txt      |    8 ++
 Documentation/devicetree/bindings/misc/fsl,mc.txt  |   40 ++++++
 .../devicetree/bindings/serial/fsl-ns16550.txt     |   24 ++++
 arch/arm64/Kconfig                                 |    5 +
 arch/arm64/boot/dts/Makefile                       |    1 +
 arch/arm64/boot/dts/fsl-ls2085a-simu.dts           |   29 ++++
 arch/arm64/boot/dts/fsl-ls2085a.dtsi               |  145 ++++++++++++++++++++
 arch/arm64/configs/defconfig                       |    1 +
 8 files changed, 253 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/fsl,mc.txt
 create mode 100644 Documentation/devicetree/bindings/serial/fsl-ns16550.txt
 create mode 100644 arch/arm64/boot/dts/fsl-ls2085a-simu.dts
 create mode 100644 arch/arm64/boot/dts/fsl-ls2085a.dtsi

-- 
1.7.9.5
