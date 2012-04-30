From: gmbnomis@gmail.com (Simon Baatz)
Date: Mon, 30 Apr 2012 23:55:16 +0200
Subject: [PATCH 0/1] kirkwood: Add support for IB-NAS6210/6220 using devicetree
Message-ID: <1335822917-16689-1-git-send-email-gmbnomis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the following patch is adding support for the kirkwood-based RaidSonic
IB-NAS6210 and IB-NAS6220 boxes.  Since these use nand, the patch is
based on Jamie Lentin's work for orion_nand devicetree bindings (as
suggested by Jason Cooper).

The patch applies on top of Jamie's V5 DNS-320 & DNS-325 patches
(http://lists.infradead.org/pipermail/linux-arm-kernel/2012-April/094739.html)
on top of v3.4-rc5.

Please let me know if I should rebase to somewhere else or if I should
structure the patch differently in general.

- Simon

Simon Baatz (1):
  ARM: kirkwood: Add support for RaidSonic IB-NAS6210/6220 using
    devicetree

 arch/arm/boot/dts/kirkwood-ib62x0.dts |   44 ++++++++++
 arch/arm/mach-kirkwood/Kconfig        |    8 ++
 arch/arm/mach-kirkwood/Makefile       |    1 +
 arch/arm/mach-kirkwood/Makefile.boot  |    1 +
 arch/arm/mach-kirkwood/board-dt.c     |    4 +
 arch/arm/mach-kirkwood/board-ib62x0.c |  143 +++++++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/common.h       |    6 ++
 7 files changed, 207 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-ib62x0.dts
 create mode 100644 arch/arm/mach-kirkwood/board-ib62x0.c

-- 
1.7.5.4
