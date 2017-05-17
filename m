From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 17 May 2017 23:50:13 +0800
Subject: [PATCH 0/4] ARM: imx: add imx7ulp support
Message-ID: <1495036217-20049-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds the basic support for imx7ulp.
It includes machine level support code and device tree.

It depends on some of other driver patch series as follows which
were sent out a few days ago and still under review:

[PATCH 0/9] clk: add imx7ulp clk support
https://www.spinics.net/lists/linux-clk/msg17037.html

[PATCH V2 0/6] tty: serial: lpuart: add imx7ulp support
https://www.spinics.net/lists/arm-kernel/msg581005.html

[PATCH 0/2] gpio: add imx7ulp gpio support
https://www.spinics.net/lists/arm-kernel/msg580990.html

[PATCH 0/2] pinctrl: pinctrl-imx: add gpio support for mx7ulp
https://www.spinics.net/lists/arm-kernel/msg580993.html

[PATCH 0/5] pinctrl: imx: add generic pin config and imx7ulp support
https://www.spinics.net/lists/arm-kernel/msg580737.html

[PATCH 1/2] dt-bindings: timer: add nxp tpm timer binding doc
https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1395534.html

[PATCH 2/2] timer: imx-tpm: add imx tpm timer support
https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1395536.html

[PATCH 0/2] gpio: add imx7ulp gpio support
https://www.spinics.net/lists/arm-kernel/msg580990.html

Shawn,

i will let you know once they're merged by each subsystem.

Dong Aisheng (4):
  dt-bindings: fsl: add compatible for imx7ulp evk
  ARM: imx: add initial support for imx7ulp
  dts: imx: add imx7ulp evk support
  ARM: imx_v6_v7_defconfig: add imx7ulp support

 Documentation/devicetree/bindings/arm/fsl.txt |   8 +
 arch/arm/boot/dts/Makefile                    |   2 +
 arch/arm/boot/dts/imx7ulp-evk.dts             |  98 ++++++++
 arch/arm/boot/dts/imx7ulp.dtsi                | 310 ++++++++++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig          |   5 +-
 arch/arm/mach-imx/Kconfig                     |   9 +
 arch/arm/mach-imx/Makefile                    |   1 +
 arch/arm/mach-imx/common.h                    |   1 +
 arch/arm/mach-imx/cpu.c                       |   3 +
 arch/arm/mach-imx/mach-imx7ulp.c              |  37 +++
 arch/arm/mach-imx/mxc.h                       |   1 +
 arch/arm/mach-imx/pm-imx7ulp.c                |  33 +++
 12 files changed, 506 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx7ulp-evk.dts
 create mode 100644 arch/arm/boot/dts/imx7ulp.dtsi
 create mode 100644 arch/arm/mach-imx/mach-imx7ulp.c
 create mode 100644 arch/arm/mach-imx/pm-imx7ulp.c

-- 
2.7.4
