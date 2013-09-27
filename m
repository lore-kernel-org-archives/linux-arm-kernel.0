From: robherring2@gmail.com (Rob Herring)
Date: Thu, 26 Sep 2013 21:24:48 -0500
Subject: [PATCH v4 0/6] PSCI support for highbank
Message-ID: <1380248694-13388-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This series converts highbank to use PSCI calls for smp_ops, suspend and
cpuidle. I've dropped system reset and poweroff until we can finalize
PSCI 0.2 bindings. Otherwise, this is mostly unchanged from the previous
posting.

New in this posting is enabling cpuidle on ecx-2000.

Rob Herring (6):
  cpuidle: calxeda: add support to use PSCI calls
  cpuidle: calxeda: add cpu_pm_enter/exit calls
  cpuidle: calxeda: add ecx-2000 support
  ARM: PSCI: remove unnecessary include of arm-gic.h
  ARM: highbank: adapt to use ARM PSCI calls
  dts: calxeda: add ARM PSCI binding

 arch/arm/boot/dts/ecx-common.dtsi |  8 +++++
 arch/arm/kernel/psci_smp.c        |  1 -
 arch/arm/mach-highbank/Kconfig    |  1 +
 arch/arm/mach-highbank/Makefile   |  2 --
 arch/arm/mach-highbank/core.h     |  4 ---
 arch/arm/mach-highbank/highbank.c | 16 +--------
 arch/arm/mach-highbank/hotplug.c  | 37 ---------------------
 arch/arm/mach-highbank/platsmp.c  | 68 ---------------------------------------
 arch/arm/mach-highbank/pm.c       | 27 ++++++----------
 drivers/cpuidle/Kconfig.arm       |  2 +-
 drivers/cpuidle/cpuidle-calxeda.c | 46 +++++++-------------------
 11 files changed, 32 insertions(+), 180 deletions(-)
 delete mode 100644 arch/arm/mach-highbank/hotplug.c
 delete mode 100644 arch/arm/mach-highbank/platsmp.c

-- 
1.8.1.2
