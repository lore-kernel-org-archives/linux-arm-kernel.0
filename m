From: chao.xie@marvell.com (Chao Xie)
Date: Wed, 26 Mar 2014 12:52:39 +0800
Subject: [PATCH 0/4] arm: mmp: timer driver
Message-ID: <1395809563-31872-1-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

These patch will create a new timer driver in drivers/clocksource/
The timer driver will support all SOCes in mach-mmp

There are two patches #2 and #3 changing the arch/mach-mmp to make
DT and no-DT supported SOCes to make use of new timer driver

The final patch will remove the old timer driver.

The patches are tested at pxa910 and mmp2(DT and no-DT support).
Because pxa168 is too old, and it is hard to find the board. So
only pass the compiling.

Chao Xie (4):
  clocksource: mmp: add mmp timer driver
  arm: mmp: make SOCes without DT use new timer driver
  arm: mmp: make SOCes with DT use new timer driver
  arm: mmp: remove the old timer driver

 .../devicetree/bindings/arm/mrvl/timer.txt         |  73 +-
 arch/arm/boot/dts/mmp2.dtsi                        |  25 +-
 arch/arm/boot/dts/pxa168.dtsi                      |  32 +-
 arch/arm/boot/dts/pxa910.dtsi                      |  32 +-
 arch/arm/mach-mmp/Kconfig                          |   2 +
 arch/arm/mach-mmp/Makefile                         |   2 +-
 arch/arm/mach-mmp/common.h                         |   2 -
 arch/arm/mach-mmp/mmp-dt.c                         |  11 +-
 arch/arm/mach-mmp/mmp2-dt.c                        |  11 +-
 arch/arm/mach-mmp/mmp2.c                           |  23 +-
 arch/arm/mach-mmp/pxa168.c                         |  23 +-
 arch/arm/mach-mmp/pxa910.c                         |  24 +-
 arch/arm/mach-mmp/time.c                           | 247 ------
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-mmp.c                    | 866 +++++++++++++++++++++
 15 files changed, 1089 insertions(+), 285 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/time.c
 create mode 100644 drivers/clocksource/timer-mmp.c

-- 
1.8.3.2
