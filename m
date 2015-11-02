From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Mon, 2 Nov 2015 16:17:10 +0100
Subject: [PATCH v8 0/2] Sigma Designs Tango4 port
Message-ID: <56377E76.2080209@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I've added L2 cache enabling, and booting the second core (both via
smc calls to the firmware). I think all the "basic" features are now
supported. Future step will be adding drivers for peripheral devices.
(However, most of our drivers definitely do not meet the stringent
quality requirements of the Linux kernel, and are also not DT).

I'm hoping this patch set is close to being accepted :-)

Regards.


Marc Gonzalez (2):
  arm-soc: Import initial tango4 device tree
  arm-soc: Add support for arm-based tango4 platforms

 arch/arm/Kconfig                          |   2 +
 arch/arm/Makefile                         |   1 +
 arch/arm/boot/dts/Makefile                |   2 +
 arch/arm/boot/dts/tango4-common.dtsi      | 121 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/tango4-smp8758.dtsi     |  30 ++++++++
 arch/arm/boot/dts/tango4-vantage-1172.dts |  24 ++++++
 arch/arm/mach-tangox/Kconfig              |  12 +++
 arch/arm/mach-tangox/Makefile             |   2 +
 arch/arm/mach-tangox/setup.c              |  32 ++++++++
 arch/arm/mach-tangox/smc.S                |   9 +++
 arch/arm/mach-tangox/smc.h                |   5 ++
 11 files changed, 240 insertions(+)
 create mode 100644 arch/arm/boot/dts/tango4-common.dtsi
 create mode 100644 arch/arm/boot/dts/tango4-smp8758.dtsi
 create mode 100644 arch/arm/boot/dts/tango4-vantage-1172.dts
 create mode 100644 arch/arm/mach-tangox/Kconfig
 create mode 100644 arch/arm/mach-tangox/Makefile
 create mode 100644 arch/arm/mach-tangox/setup.c
 create mode 100644 arch/arm/mach-tangox/smc.S
 create mode 100644 arch/arm/mach-tangox/smc.h

-- 
2.4.5
