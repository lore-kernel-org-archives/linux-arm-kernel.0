From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 13 May 2014 22:12:13 +0800
Subject: [PATCH 0/6] ARM: imx: add initial i.MX6 SoloX support
Message-ID: <1399990339-12677-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series adds the initial support for i.MX6 SoloX, which is the newest
addition to i.MX6 family SoCs.  It integrates one Cortex-A9 and one
Cortex-M4, and features dual-port gigabit Ethernet audio video
bridging (AVB) for quality-of-service in automotive and other
applications with enhanced traffic shaping and packet prioritization.
More details can be found in page below.

http://media.freescale.com/phoenix.zhtml?c=196520&p=irol-newsArticle&ID=1917475&highlight

Shawn

Anson Huang (1):
  ARM: imx: add clock driver for imx6sx

Shawn Guo (5):
  ARM: imx: add low-level debug support for imx6sx
  ARM: imx: add basic imx6sx SoC support
  ARM: dts: imx: add pin function header for imx6sx
  ARM: dts: imx: add initial imx6sx device tree source
  ARM: dts: imx: add initial imx6sx-sdb board support

 .../devicetree/bindings/clock/imx6sx-clock.txt     |   13 +
 arch/arm/Kconfig.debug                             |   13 +-
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/imx6sx-pinfunc.h                 | 1544 ++++++++++++++++++++
 arch/arm/boot/dts/imx6sx-sdb.dts                   |  210 +++
 arch/arm/boot/dts/imx6sx.dtsi                      | 1202 +++++++++++++++
 arch/arm/include/debug/imx-uart.h                  |   11 +
 arch/arm/mach-imx/Kconfig                          |    8 +
 arch/arm/mach-imx/Makefile                         |    1 +
 arch/arm/mach-imx/clk-imx6sx.c                     |  524 +++++++
 arch/arm/mach-imx/cpu.c                            |    3 +
 arch/arm/mach-imx/mach-imx6sx.c                    |   51 +
 arch/arm/mach-imx/mxc.h                            |    6 +
 include/dt-bindings/clock/imx6sx-clock.h           |  256 ++++
 14 files changed, 3841 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx6sx-clock.txt
 create mode 100755 arch/arm/boot/dts/imx6sx-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imx6sx-sdb.dts
 create mode 100644 arch/arm/boot/dts/imx6sx.dtsi
 create mode 100644 arch/arm/mach-imx/clk-imx6sx.c
 create mode 100644 arch/arm/mach-imx/mach-imx6sx.c
 create mode 100644 include/dt-bindings/clock/imx6sx-clock.h

-- 
1.8.3.2
