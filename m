From: b35083@freescale.com (Jingchang Lu)
Date: Thu, 16 May 2013 14:10:44 +0800
Subject: [PATCH v3 0/4] Add initial Freescale Vybrid MVF600 support
Message-ID: <1368684648-20826-1-git-send-email-b35083@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vybird MVF600 is a heterogeneous dual-core eMPU using ARM Cortex-A5 and
Cortex-M4 cores. The kernel are implemented on the Cortex-A5 core.
The core is different with current I.MX serial. However, This SOC
still shares some IPs with I.MX serials, such as FEC, ESDHC, WATCHDOG,
I2C, ASRC and ESAI, This SOC also shares some IPs with ColdFire platform,
such as eDMA and DSPI. And this SOC still have its own IPs such as PIT,
SAI, UART, QuadSPI and DCU.

Jingchang Lu (4):
  ARM: imx: add MVF600 clock support
  ARM: imx: add initial support for MVF600
  ARM: dts: add SoC level device tree source for MVF600
  ARM: dts: add initial MVF600 Tower board dts support

 Documentation/devicetree/bindings/clock/mvf600-clock.txt |  26 ++
 arch/arm/boot/dts/Makefile                               |   3 +-
 arch/arm/boot/dts/mvf600-pinfunc.h                       | 810 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/mvf600-twr.dts                         | 108 +++++
 arch/arm/boot/dts/mvf600.dtsi                            | 475 ++++++++++++++++++++
 arch/arm/mach-imx/Kconfig                                |  15 +
 arch/arm/mach-imx/Makefile                               |   2 +
 arch/arm/mach-imx/clk-mvf600.c                           | 322 ++++++++++++++
 arch/arm/mach-imx/common.h                               |   1 +
 arch/arm/mach-imx/mach-mvf600.c                          |  70 +++
 include/dt-bindings/clock/mvf600-clock.h                 | 163 +++++++
 11 files changed, 1994 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mvf600-clock.txt
 create mode 100644 arch/arm/boot/dts/mvf600-pinfunc.h
 create mode 100644 arch/arm/boot/dts/mvf600-twr.dts
 create mode 100644 arch/arm/boot/dts/mvf600.dtsi
 create mode 100644 arch/arm/mach-imx/clk-mvf600.c
 create mode 100644 arch/arm/mach-imx/mach-mvf600.c
 create mode 100644 include/dt-bindings/clock/mvf600-clock.h
