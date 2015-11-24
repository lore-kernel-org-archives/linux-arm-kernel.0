From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 24 Nov 2015 18:15:38 +0100
Subject: [PATCH v10 0/2] Sigma Designs Tango4 port
Message-ID: <56549B3A.8010703@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One more time. (We're gonna celebrate)

Changes planned for a future patch series:
Have clkgen driver export CD2/2 (for USB) and CD6/2 (for SDIO)

Changes since v9:
Rename mach-tangox to mach-tango and ARCH_TANGOX to ARCH_TANGO (??)
=> Should I instead define ARCH_TANGO4 and later define ARCH_TANGO5?
Add entry in MAINTAINERS
Delete pr_debug() call
=> mach code is not supposed to use this function?

Marc Gonzalez (2):
  arm-soc: Import initial tango4 device tree
  arm-soc: Add support for tango4 platforms

 MAINTAINERS                               |   7 ++
 arch/arm/Kconfig                          |   2 +
 arch/arm/Makefile                         |   1 +
 arch/arm/boot/dts/Makefile                |   2 +
 arch/arm/boot/dts/tango4-common.dtsi      | 121 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/tango4-smp8758.dtsi     |  31 ++++++++
 arch/arm/boot/dts/tango4-vantage-1172.dts |  29 +++++++
 arch/arm/mach-tango/Kconfig               |  12 +++
 arch/arm/mach-tango/Makefile              |   2 +
 arch/arm/mach-tango/setup.c               |  31 ++++++++
 arch/arm/mach-tango/smc.S                 |   9 +++
 arch/arm/mach-tango/smc.h                 |   5 ++
 12 files changed, 252 insertions(+)
 create mode 100644 arch/arm/boot/dts/tango4-common.dtsi
 create mode 100644 arch/arm/boot/dts/tango4-smp8758.dtsi
 create mode 100644 arch/arm/boot/dts/tango4-vantage-1172.dts
 create mode 100644 arch/arm/mach-tango/Kconfig
 create mode 100644 arch/arm/mach-tango/Makefile
 create mode 100644 arch/arm/mach-tango/setup.c
 create mode 100644 arch/arm/mach-tango/smc.S
 create mode 100644 arch/arm/mach-tango/smc.h

-- 
2.4.5
