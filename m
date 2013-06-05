From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed,  5 Jun 2013 12:46:05 +0100
Subject: [RFC PATCH v2 0/2] drivers: mfd: Versatile Express SPC support
Message-ID: <1370432767-6620-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is v2 of a previous posting:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/170624.html

V2 changes:

- Dropped timeout interface patch
- Converted interfaces to non-timeout ones, integrated and retested
- Removed mutex used at init
- Refactored code to work around init sections warning
- Fixed interface type enumeration init
- Fixed data write in SYSCFG write commands

This patch series introduces support for the Versatile Express Serial
Power Controller (SPC) present in ARM Versatile Express TC2 core tiles.
SPC driver is a fundamental component of TC2 power management and allows
to carry out C-state management and DVFS for A15 and A7 clusters.

First patch provides changes required by SPC to comply with the
Versatile Express config API, second patch is the SPC driver implementation.

Code extensively exercised through CPUidle and CPUfreq power states and
operating point transitions.

Lorenzo Pieralisi (1):
  drivers: mfd: vexpress: add Serial Power Controller (SPC) support

Pawel Moll (1):
  drivers: mfd: refactor the vexpress config bridge API

 .../devicetree/bindings/mfd/vexpress-spc.txt       |  35 ++
 drivers/mfd/Kconfig                                |   7 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/vexpress-config.c                      |  61 +-
 drivers/mfd/vexpress-spc.c                         | 630 +++++++++++++++++++++
 drivers/mfd/vexpress-sysreg.c                      |   2 +-
 include/linux/vexpress.h                           |  59 +-
 7 files changed, 767 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/vexpress-spc.txt
 create mode 100644 drivers/mfd/vexpress-spc.c

-- 
1.8.2.2
