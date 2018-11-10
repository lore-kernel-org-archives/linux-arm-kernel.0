From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sat, 10 Nov 2018 15:12:52 +0000
Subject: [PATCH V5 0/6] ARM: imx: add imx7ulp support
Message-ID: <1541862478-7839-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX 7ULP family of processors represents NXP?s latest achievement
in ultra-low-power processing for use cases demanding long battery life.
Targeted towards the growing market of portable devices, the i.MX 7ULP
family of processors features NXP's advanced implementation of the Arm?
Cortex-A7 core, the Arm Cortex-M4 core, as well as a 3D and 2D Graphics
Processing Units (GPUs). The i.MX 7ULP family provides up to 32-bit
LPDDR2/LPDDR3 memory interface and a number of other interfaces for
connecting peripherals, such as WLAN, Bluetooth, GPS, displays, and
camera sensors.

This patch series adds the basic support for imx7ulp. It includes machine
level support code and device tree.
Note: it depends on clk driver which is still under review.

v4->v5:
 * dts add input clocks for PCC module
 * update pad setting due to missing pull up enabled
   (formerly auto done by driver generic pinconfg)
 * gpio and pinctrl patches were merged by Linus W, so dropped in this series
  dt-bindings: gpio: vf610: add optional clocks property
  gpio: vf610: add optional clock support
  dt-bindings: pinctrl: imx7ulp: back to imx legacy binding for
    consistency
  pinctrl: fsl: imx7ulp: change to use imx legacy binding

v3->v4:
 * add comments about fixed soc version
 * add iounmap
v2->v3:
 * back to old pinctrl binding according to SoC maintainer's suggestions
 * use generic node name
 * error checking updated according to Russell's suggestion:
   ptr == ERR_PTR(-EPROBE_DEFER)

v1->v2:
 * switch to SPDX license
 * rebase to latest tree
 * pad name update
 * add gpio clk support
 * minor fix



Dong Aisheng (6):
  dt-bindings: fsl: add compatible for imx7ulp evk
  dt-bindings: fsl: add imx7ulp pm related components bindings
  ARM: imx: add initial support for imx7ulp
  dts: imx: add common imx7ulp dtsi support
  dts: fsl: add imx7ulp evk support
  ARM: imx_v6_v7_defconfig: add imx7ulp support

 .../bindings/arm/freescale/fsl,imx7ulp-pm.txt      |  23 ++
 Documentation/devicetree/bindings/arm/fsl.txt      |   8 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/imx7ulp-evk.dts                  |  77 +++++
 arch/arm/boot/dts/imx7ulp.dtsi                     | 346 +++++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig               |   1 +
 arch/arm/mach-imx/Kconfig                          |   9 +
 arch/arm/mach-imx/Makefile                         |   1 +
 arch/arm/mach-imx/common.h                         |   1 +
 arch/arm/mach-imx/cpu.c                            |   3 +
 arch/arm/mach-imx/mach-imx7ulp.c                   |  33 ++
 arch/arm/mach-imx/mxc.h                            |   1 +
 arch/arm/mach-imx/pm-imx7ulp.c                     |  29 ++
 13 files changed, 534 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.txt
 create mode 100644 arch/arm/boot/dts/imx7ulp-evk.dts
 create mode 100644 arch/arm/boot/dts/imx7ulp.dtsi
 create mode 100644 arch/arm/mach-imx/mach-imx7ulp.c
 create mode 100644 arch/arm/mach-imx/pm-imx7ulp.c

-- 
2.7.4
