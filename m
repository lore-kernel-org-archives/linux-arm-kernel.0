From: zhangwm@marvell.com (Neil Zhang)
Date: Thu, 11 Apr 2013 11:37:39 +0800
Subject: [PATCH 0/4] bring up pxa988 with DT
Message-ID: <1365651463-11502-1-git-send-email-zhangwm@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch sets do the following things:
1. add wakeup function for ICU.
2. move some common funciton declaration to common.h
3. bring up pxa988 with DT support

Chao Xie (1):
  ARM: mmp: add wakeup function for ICU

Neil Zhang (3):
  ARM: mmp: move function declaration to head file
  ARM: mmp: bring up pxa988 with device tree support
  ARM: mmp: add SMP support for pxa988

 .../devicetree/bindings/arm/mrvl/intc.txt          |    9 +
 arch/arm/boot/dts/pxa988-dkb.dts                   |   36 ++++
 arch/arm/boot/dts/pxa988.dtsi                      |  196 ++++++++++++++++++++
 arch/arm/mach-mmp/Kconfig                          |   25 +++
 arch/arm/mach-mmp/Makefile                         |    5 +
 arch/arm/mach-mmp/common.c                         |   11 +-
 arch/arm/mach-mmp/common.h                         |    5 +
 arch/arm/mach-mmp/headsmp.S                        |  104 +++++++++++
 arch/arm/mach-mmp/include/mach/addr-map.h          |    6 +
 arch/arm/mach-mmp/irq.c                            |   51 ++++-
 arch/arm/mach-mmp/mmp-dt.c                         |    3 -
 arch/arm/mach-mmp/mmp2-dt.c                        |    3 -
 arch/arm/mach-mmp/mmpx-dt.c                        |   80 ++++++++
 arch/arm/mach-mmp/platsmp.c                        |  170 +++++++++++++++++
 arch/arm/mach-mmp/reset.c                          |   66 +++++++
 arch/arm/mach-mmp/reset.h                          |   29 +++
 drivers/clk/mmp/Makefile                           |    1 +
 17 files changed, 783 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm/boot/dts/pxa988-dkb.dts
 create mode 100644 arch/arm/boot/dts/pxa988.dtsi
 create mode 100644 arch/arm/mach-mmp/headsmp.S
 create mode 100644 arch/arm/mach-mmp/mmpx-dt.c
 create mode 100644 arch/arm/mach-mmp/platsmp.c
 create mode 100644 arch/arm/mach-mmp/reset.c
 create mode 100644 arch/arm/mach-mmp/reset.h

-- 
1.7.4.1
