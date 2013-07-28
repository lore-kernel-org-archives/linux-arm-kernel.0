From: robherring2@gmail.com (Rob Herring)
Date: Sun, 28 Jul 2013 16:56:31 -0500
Subject: [PATCH v3 0/7] PSCI support for highbank
Message-ID: <1375048598-15637-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This is an updated series converting highbank platform to use PSCI calls
for smp_ops, cpuidle, suspend, reset and poweroff. Since the last posting,
the PSCI spec has been updated by ARM to version 0.2 [1]. The primary
kernel visible change in the specification is the addition of system level
reset and poweroff functions.

Rob

[1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0022b/index.html

v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2013-April/159519.html
v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2013-February/151820.html

Rob Herring (7):
  dt: update PSCI binding documentation for v0.2
  ARM: PSCI: remove unnecessary include of arm-gic.h
  ARM: PSCI: add ops for system restart and power off
  cpuidle: calxeda: add support to use PSCI calls
  ARM: highbank: clean-up some unused includes
  ARM: highbank: adapt to use ARM PSCI calls
  dts: calxeda: add ARM PSCI binding

 Documentation/devicetree/bindings/arm/psci.txt | 25 ++++++--
 arch/arm/boot/dts/ecx-common.dtsi              | 10 +++
 arch/arm/include/asm/psci.h                    |  2 +
 arch/arm/kernel/psci.c                         | 40 ++++++++++++
 arch/arm/kernel/psci_smp.c                     |  1 -
 arch/arm/mach-highbank/Kconfig                 |  2 +-
 arch/arm/mach-highbank/Makefile                |  4 +-
 arch/arm/mach-highbank/core.h                  |  9 ---
 arch/arm/mach-highbank/highbank.c              | 55 +---------------
 arch/arm/mach-highbank/hotplug.c               | 37 -----------
 arch/arm/mach-highbank/platsmp.c               | 68 --------------------
 arch/arm/mach-highbank/pm.c                    | 27 +++-----
 arch/arm/mach-highbank/sysregs.h               | 86 --------------------------
 arch/arm/mach-highbank/system.c                | 33 ----------
 drivers/cpuidle/cpuidle-calxeda.c              | 40 ++----------
 15 files changed, 89 insertions(+), 350 deletions(-)
 delete mode 100644 arch/arm/mach-highbank/hotplug.c
 delete mode 100644 arch/arm/mach-highbank/platsmp.c
 delete mode 100644 arch/arm/mach-highbank/sysregs.h
 delete mode 100644 arch/arm/mach-highbank/system.c

-- 
1.8.1.2
