From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 7 Aug 2013 15:38:18 -0400
Subject: [GIT PULL] ARM: keystone: Few non-critical fixes, cleanups for 3.12
Message-ID: <1375904298-5899-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit eb788f43a6c6e6c7a5b2879543b565e4cd452de8:

  ARM: Keystone: Convert device tree file to use IRQ defines (2013-08-05 14:06:24 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-fixes-non-critical

for you to fetch changes up to eb788f43a6c6e6c7a5b2879543b565e4cd452de8:

  ARM: Keystone: Convert device tree file to use IRQ defines (2013-08-05 14:06:24 -0400)

----------------------------------------------------------------
ARM: keystone: non-critical fixes, cleanup for 3.12

Summary of changes:
	- Drop unused HAVE_SCHED_CLOCK config option
	- Remove now redundant smp_init_cpus call
	- Update the smc code to remove dsb and r12 usage
	- Convert device tree to use #include and GIC bindings

----------------------------------------------------------------

Paul Bolle (1):
  ARM: keystone: drop useless HAVE_SCHED_CLOCK

Santosh Shilimkar (4):
  ARM: Keystone: No need to preserve r12 across smc call
  ARM: keystone: Drop the un-necessary dsb from keystone_cpu_smc()
  ARM: keystone: use #include to include skeleton.dtsi
  ARM: Keystone: Convert device tree file to use IRQ defines

Sudeep KarkadaNagesha (1):
  ARM: keystone: remove redundant smp_init_cpus definition

 arch/arm/boot/dts/keystone.dts   |   29 ++++++++++++++++++-----------
 arch/arm/mach-keystone/Kconfig   |    1 -
 arch/arm/mach-keystone/platsmp.c |    1 -
 arch/arm/mach-keystone/smc.S     |    5 ++---
 4 files changed, 20 insertions(+), 16 deletions(-)

-- 
1.7.9.5
