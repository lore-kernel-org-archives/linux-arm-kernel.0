From: b35083@freescale.com (Jingchang Lu)
Date: Tue, 28 May 2013 17:12:19 +0800
Subject: [PATCH v4 0/4] Add initial Freescale Vybrid VF610 support
Message-ID: <1369732343-2982-1-git-send-email-b35083@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Vybird VF610 is a heterogeneous dual-core eMPU using ARM Cortex-A5 and
Cortex-M4 cores. The kernel is implemented on the Cortex-A5 core.
  This SoC shares some IPs with I.MX serials, such as FEC, ESDHC, WATCHDOG,
I2C, ASRC and ESAI, this SOC also shares some IPs with ColdFire platform,
such as eDMA and DSPI, and this SOC have its own IPs such as PIT, SAI, UART,
QuadSPI and DCU.
  More documents for this soc can be found at:
  http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=VF6xx&fsrch=1&sr=5
  http://www.freescale.com/webapp/sps/site/homepage.jsp?code=VYBRID

changes in v4:
	Follow internal suggestions to name the soc name as VF610.
	Use common of_clk_init() call to initialize clocks.
	Name lpuart device compatible string to "fsl,vf610-lpuart".
	Remove "fsl,mvf-fec" compatible string.
	Remove node of QuadSPI, I2C, SAI, and sound until driver accepted.
changes in v3:
	Split one big arch support patch to small patches.
	Use DTC macro support to define these clock IDs.
	Remove unused #include header lines.
	Name clocks close to reference manual.
	Use common mxc restart function.
	Define mvf600 pinfunc ID as <mux_reg input_reg mux_mode input_val>.
	Sort dts node by alphabet order of labels.
changes in v2:
	Add more clks definitions.
	Add pinctrl support based on IMX new pinctrl framework.

Jingchang Lu (4):
  ARM: imx: add VF610 clock support
  ARM: imx: add initial support for VF610
  ARM: dts: add SoC level device tree source for VF610
  ARM: dts: add initial VF610 Tower board dts support

Documentation/devicetree/bindings/clock/vf610-clock.txt |  26 ++
 arch/arm/boot/dts/Makefile                              |   3 +-
 arch/arm/boot/dts/vf610-pinfunc.h                       | 810 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/vf610-twr.dts                         |  57 +++
 arch/arm/boot/dts/vf610.dtsi                            | 464 +++++++++++++++++++++
 arch/arm/mach-imx/Kconfig                               |  15 +
 arch/arm/mach-imx/Makefile                              |   2 +
 arch/arm/mach-imx/clk-vf610.c                           | 319 ++++++++++++++
 arch/arm/mach-imx/mach-vf610.c                          |  48 +++
 include/dt-bindings/clock/vf610-clock.h                 | 163 ++++++++
 10 files changed, 1906 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/vf610-clock.txt
 create mode 100644 arch/arm/boot/dts/vf610-pinfunc.h
 create mode 100644 arch/arm/boot/dts/vf610-twr.dts
 create mode 100644 arch/arm/boot/dts/vf610.dtsi
 create mode 100644 arch/arm/mach-imx/clk-vf610.c
 create mode 100644 arch/arm/mach-imx/mach-vf610.c
 create mode 100644 include/dt-bindings/clock/vf610-clock.h
