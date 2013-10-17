From: robherring2@gmail.com (Rob Herring)
Date: Thu, 17 Oct 2013 13:58:21 -0500
Subject: [GIT PULL] Highbank updates for 3.13
Message-ID: <5260334D.30009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin, Olof,

Please pull. Doing merge with arm-soc/for-next, there's a trivial merge
conflict with highbank.c includes.

Rob

The following changes since commit 15c03dd4859ab16f9212238f29dd315654aa94f6:

  Linux 3.12-rc3 (2013-09-29 15:02:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
tags/highbank-for-3.13

for you to fetch changes up to 78bbca1a54bd05f7c7d38a306073a3ee7f866e51:

  dts: calxeda: add ARM PSCI binding (2013-10-01 16:34:17 -0500)

----------------------------------------------------------------
Highbank platform updates for 3.13

- convert Calxeda cpuidle driver to a platform driver and to use PSCI
- convert highbank smp_ops and suspend to PSCI

----------------------------------------------------------------
Daniel Lezcano (1):
      ARM: highbank: cpuidle: convert to platform driver

Rob Herring (5):
      cpuidle: calxeda: add cpu_pm_enter/exit calls
      cpuidle: calxeda: add support to use PSCI calls
      ARM: PSCI: remove unnecessary include of arm-gic.h
      ARM: highbank: adapt to use ARM PSCI calls
      dts: calxeda: add ARM PSCI binding

 arch/arm/boot/dts/ecx-common.dtsi |  8 +++++
 arch/arm/kernel/psci_smp.c        |  1 -
 arch/arm/mach-highbank/Kconfig    |  1 +
 arch/arm/mach-highbank/Makefile   |  2 --
 arch/arm/mach-highbank/core.h     |  4 ---
 arch/arm/mach-highbank/highbank.c | 24 ++++++--------
 arch/arm/mach-highbank/hotplug.c  | 37 ---------------------
 arch/arm/mach-highbank/platsmp.c  | 68
---------------------------------------
 arch/arm/mach-highbank/pm.c       | 27 ++++++----------
 drivers/cpuidle/Kconfig.arm       |  2 +-
 drivers/cpuidle/cpuidle-calxeda.c | 61 +++++++++++++----------------------
 11 files changed, 50 insertions(+), 185 deletions(-)
 delete mode 100644 arch/arm/mach-highbank/hotplug.c
 delete mode 100644 arch/arm/mach-highbank/platsmp.c
