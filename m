From: zhangwm@marvell.com (Neil Zhang)
Date: Fri, 31 May 2013 10:58:34 +0800
Subject: [PATCH v2] bring up pxa988 with DT
Message-ID: <1369969115-4279-1-git-send-email-zhangwm@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is supposed to bring up pxa988 SMP.
will change to use CLOCKSOURCE later.

ChangeLog
V2:
1. use early_init call for handler init.
2. Add sanity check for maximum core count.

Neil Zhang (1):
  ARM: mmp: bring up pxa988 with device tree support

 arch/arm/boot/dts/pxa988-dkb.dts          |   36 ++++++
 arch/arm/boot/dts/pxa988.dtsi             |  189 +++++++++++++++++++++++++++++
 arch/arm/mach-mmp/Kconfig                 |   27 ++++
 arch/arm/mach-mmp/Makefile                |    2 +
 arch/arm/mach-mmp/common.c                |   11 ++-
 arch/arm/mach-mmp/common.h                |    2 +
 arch/arm/mach-mmp/headsmp.S               |  104 ++++++++++++++++
 arch/arm/mach-mmp/include/mach/addr-map.h |    6 +
 arch/arm/mach-mmp/mmpx-dt.c               |   74 +++++++++++
 arch/arm/mach-mmp/platsmp.c               |  167 +++++++++++++++++++++++++
 arch/arm/mach-mmp/reset.c                 |   68 ++++++++++
 arch/arm/mach-mmp/reset.h                 |   28 +++++
 drivers/clk/mmp/Makefile                  |    1 +
 13 files changed, 714 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/boot/dts/pxa988-dkb.dts
 create mode 100644 arch/arm/boot/dts/pxa988.dtsi
 create mode 100644 arch/arm/mach-mmp/headsmp.S
 create mode 100644 arch/arm/mach-mmp/mmpx-dt.c
 create mode 100644 arch/arm/mach-mmp/platsmp.c
 create mode 100644 arch/arm/mach-mmp/reset.c
 create mode 100644 arch/arm/mach-mmp/reset.h

-- 
1.7.4.1
