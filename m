From: gerg@uclinux.org (gerg at uclinux.org)
Date: Fri, 18 Oct 2013 16:04:12 +1000
Subject: [PATCH 0/8] ARM: imx: add IMX50 SoC support
Message-ID: <1382076260-6422-1-git-send-email-gerg@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Greg Ungerer <gerg@uclinux.org>

This set of patches is the code and device tree support for the Freescale
IMX50 SoC. This part is similar to the IMX53 SoC family, and I have resued
as much of its support as possible. These patches are against 3.12-rc5.

With these changes you can load and run on the Freescale IMX50-EVK board.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/arm/Kconfig.debug              |    9 
 arch/arm/boot/dts/Makefile          |    1 
 arch/arm/boot/dts/imx50-evk.dts     |   89 +++
 arch/arm/boot/dts/imx50-pinfunc.h   |  923 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx50.dtsi        |  659 +++++++++++++++++++++++++
 arch/arm/include/debug/imx-uart.h   |   10 
 arch/arm/mach-imx/Kconfig           |    9 
 arch/arm/mach-imx/Makefile          |    1 
 arch/arm/mach-imx/clk-imx51-imx53.c |   79 +++
 arch/arm/mach-imx/common.h          |    3 
 arch/arm/mach-imx/mach-imx50.c      |   52 ++
 drivers/pinctrl/Kconfig             |    8 
 drivers/pinctrl/Makefile            |    1 
 drivers/pinctrl/pinctrl-imx50.c     |  426 ++++++++++++++++
 14 files changed, 2270 insertions(+)
