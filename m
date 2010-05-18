From: sundar.iyer@stericsson.com (Sundar Iyer)
Date: Tue, 18 May 2010 14:06:23 +0530
Subject: [PATCH 0/3] ux500: Add basic PM support
Message-ID: <1274171786-22990-1-git-send-email-sundar.iyer@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sundar R Iyer <sundar.iyer@stericsson.com>

The following patches add basic power management support
for the ux500 platforms. Please note that this is available only
on the U8500 v1.0 versions of the HW.

Kumar Sanghvi (1):
  ux500: Add basic PRCM TCDM support

Sundar R Iyer (2):
  ux500: Add cpu hotplug suport for ux500 platform
  ux500: Add CPUFreq support

 arch/arm/mach-ux500/Kconfig                        |    1 +
 arch/arm/mach-ux500/Makefile                       |    5 +-
 arch/arm/mach-ux500/cpu-db8500.c                   |    1 +
 arch/arm/mach-ux500/hotplug.c                      |   87 +++++++
 arch/arm/mach-ux500/include/mach/hardware.h        |    1 +
 arch/arm/mach-ux500/include/mach/irqs.h            |    1 +
 arch/arm/mach-ux500/include/mach/u8500-prcm-api.h  |   42 ++++
 arch/arm/mach-ux500/include/mach/u8500-prcm-regs.h |   28 +++
 arch/arm/mach-ux500/include/mach/u8500-prcm.h      |   57 +++++
 arch/arm/mach-ux500/platsmp.c                      |    2 +
 arch/arm/mach-ux500/u8500-prcm.c                   |  243 ++++++++++++++++++++
 11 files changed, 467 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-ux500/hotplug.c
 create mode 100644 arch/arm/mach-ux500/include/mach/u8500-prcm-api.h
 create mode 100644 arch/arm/mach-ux500/include/mach/u8500-prcm-regs.h
 create mode 100644 arch/arm/mach-ux500/include/mach/u8500-prcm.h
 create mode 100644 arch/arm/mach-ux500/u8500-prcm.c
