From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 15 Dec 2015 10:37:23 +0100
Subject: [PATCH v11 0/2] Sigma Designs Tango4 port
Message-ID: <566FDF53.3030004@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"One more time. We're gonna celebrate."

Changes since v10:
Add aliases and chosen DT nodes
Use CPU_CLK and SYS_CLK symbolic names
MPCore private memory region DT node
select TANGO_IRQ instead of GENERIC_IRQ_CHIP

Changes planned for a future patch series:
Have clkgen driver export CD2 for USB, and CD6 for SDIO

Marc Gonzalez (2):
  arm-soc: Import initial tango4 device tree
  arm-soc: Add support for tango4 platforms

 MAINTAINERS                               |   7 ++
 arch/arm/Kconfig                          |   2 +
 arch/arm/Makefile                         |   1 +
 arch/arm/boot/dts/Makefile                |   2 +
 arch/arm/boot/dts/tango4-common.dtsi      | 130 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/tango4-smp8758.dtsi     |  31 +++++++
 arch/arm/boot/dts/tango4-vantage-1172.dts |  37 +++++++++
 arch/arm/mach-tango/Kconfig               |  12 +++
 arch/arm/mach-tango/Makefile              |   2 +
 arch/arm/mach-tango/setup.c               |  31 +++++++
 arch/arm/mach-tango/smc.S                 |   9 +++
 arch/arm/mach-tango/smc.h                 |   5 ++
 12 files changed, 269 insertions(+)
 create mode 100644 arch/arm/boot/dts/tango4-common.dtsi
 create mode 100644 arch/arm/boot/dts/tango4-smp8758.dtsi
 create mode 100644 arch/arm/boot/dts/tango4-vantage-1172.dts
 create mode 100644 arch/arm/mach-tango/Kconfig
 create mode 100644 arch/arm/mach-tango/Makefile
 create mode 100644 arch/arm/mach-tango/setup.c
 create mode 100644 arch/arm/mach-tango/smc.S
 create mode 100644 arch/arm/mach-tango/smc.h

-- 
2.6.3
