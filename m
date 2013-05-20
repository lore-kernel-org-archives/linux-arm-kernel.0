From: sanjay.rawat@linaro.org (Sanjay Singh Rawat)
Date: Mon, 20 May 2013 12:03:22 +0530
Subject: [RFC PATCH 0/6] ARM: cpuhotplug: move common functions to core
Message-ID: <1369031608-27347-1-git-send-email-sanjay.rawat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Various SoCs with arm processors define their own platform hotplug related
functions. These functions can be defined as part of the core cpu hotplug
functions, this will avoid the duplication. This patchset is intended to
address this issue.

This patchset covers arm-Cortex-A9 of exynos, imx, realview, spear and
vexpress SoCs. Not having h/w, the patch is not tested.

Sanjay Singh Rawat (6):
  ARM: cpuhotplug: move common hotplug related functions to core
  ARM: imx: use the core cpu hotplug functions
  ARM: RealView: use the core cpu hotplug functions
  ARM: spear: use the core cpu hotplug functions
  ARM: vexpress: use the core cpu hotplug functions
  ARM: EXYNOS: use the core cpu hotplug functions

 arch/arm/include/asm/hotplug.h   |   24 ++++++++++++++
 arch/arm/kernel/Makefile         |    1 +
 arch/arm/kernel/cpuhotplug.c     |   64 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-exynos/hotplug.c   |   40 ++----------------------
 arch/arm/mach-imx/hotplug.c      |   22 +------------
 arch/arm/mach-realview/hotplug.c |   37 +---------------------
 arch/arm/mach-spear/hotplug.c    |   37 +---------------------
 arch/arm/mach-vexpress/hotplug.c |   38 +---------------------
 8 files changed, 95 insertions(+), 168 deletions(-)
 create mode 100644 arch/arm/include/asm/hotplug.h
 create mode 100644 arch/arm/kernel/cpuhotplug.c

-- 
1.7.9.5
