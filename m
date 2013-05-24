From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 24 May 2013 13:53:03 +0100
Subject: [RFC PATCH 0/3] drivers: mfd: Versatile Express SPC support
Message-ID: <1369399986-15649-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series introduces support for the Versatile Express Serial
Power Controller (SPC) present in ARM Versatile Express TC2 core tiles.
SPC driver is a fundamental component of TC2 power management and allows
to carry out C-state management and DVFS for A15 and A7 clusters.

First two patches provide changes required by SPC to comply with the
Versatile Express config API, third patch is the SPC driver implementation.

Code extensively exercised through CPUidle and CPUfreq power states and
operating point transitions.

Lorenzo Pieralisi (2):
  drivers: mfd: vexpress: add timeout API to vexpress config interface
  drivers: mfd: vexpress: add Serial Power Controller (SPC) support

Pawel Moll (1):
  drivers: mfd: refactor the vexpress config bridge API

 Documentation/devicetree/bindings/mfd/vexpress-spc.txt |  35 +
 drivers/mfd/Kconfig                                    |   7 +
 drivers/mfd/Makefile                                   |   1 +
 drivers/mfd/vexpress-config.c                          |  87 +-
 drivers/mfd/vexpress-spc.c                             | 626 ++++++++++
 drivers/mfd/vexpress-sysreg.c                          |   2 +-
 include/linux/vexpress.h                               |  82 +-
 7 files changed, 800 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/vexpress-spc.txt
 create mode 100644 drivers/mfd/vexpress-spc.c

-- 
1.8.2.2
