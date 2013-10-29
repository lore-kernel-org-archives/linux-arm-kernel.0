From: gerg@uclinux.org (gerg at uclinux.org)
Date: Tue, 29 Oct 2013 15:15:50 +1000
Subject: [PATCHv2 0/7] ARM: imx: add IMX50 SoC support
Message-ID: <1383023757-30711-1-git-send-email-gerg@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Greg Ungerer <gerg@uclinux.org>

This set of patches is the code and device tree support for the Freescale
IMX50 SoC. This part is similar to the IMX53 SoC family, and I have resued
as much of its support as possible. These patches are against Shawn Guo's
linux-2.6.git for-next branch.

This loads and runs on the Freescale IMX50-EVK board.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
v2: made the pinctrl changes a separate patch stream
    fixups for applying to Shawn's for-next branch
    initial values for some pad control settings

 arch/arm/Kconfig.debug              |    9 
 arch/arm/boot/dts/Makefile          |    1 
 arch/arm/boot/dts/imx50-evk.dts     |   85 +++
 arch/arm/boot/dts/imx50-pinfunc.h   |  923 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx50.dtsi        |  670 ++++++++++++++++++++++++++
 arch/arm/include/debug/imx-uart.h   |   10 
 arch/arm/mach-imx/Kconfig           |    8 
 arch/arm/mach-imx/Makefile          |    1 
 arch/arm/mach-imx/clk-imx51-imx53.c |   58 ++
 arch/arm/mach-imx/mach-imx50.c      |   46 +
 10 files changed, 1811 insertions(+)
