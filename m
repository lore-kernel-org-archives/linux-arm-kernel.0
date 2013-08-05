From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 5 Aug 2013 14:11:07 -0400
Subject: [RESEND PATCH 0/7] ARM: keystone: Few non-critical fixes,
 cleanups for 3.12
Message-ID: <1375726274-26000-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are few non-critical fixes, cleanups for the Keystone SOCs
targeted for 3.12 merge window.

Brief summary of changes:
	- Drop unused HAVE_SCHED_CLOCK config option
	- Remove now redundant keystone_cpu_smc() call
	- Update the smc code to remove dsb and r12 usage
	- Convert device tree to use #include and GIC bindings
	- Update the MAINTAINER file.

Boot tested on Kesytone 2 EVM.

Paul Bolle (1):
  ARM: keystone: drop useless HAVE_SCHED_CLOCK

Santosh Shilimkar (5):
  ARM: Keystone: No need to preserve r12 across smc call
  ARM: keystone: Drop the un-necessary dsb from keystone_cpu_smc()
  ARM: keystone: use #include to include skeleton.dtsi
  ARM: Keystone: Convert device tree file to use IRQ defines
  MAINTAINERS: add TI Keystone ARM platform

Sudeep KarkadaNagesha (1):
  ARM: keystone: remove redundant smp_init_cpus definition

 MAINTAINERS                      |    6 ++++++
 arch/arm/boot/dts/keystone.dts   |   29 ++++++++++++++++++-----------
 arch/arm/mach-keystone/Kconfig   |    1 -
 arch/arm/mach-keystone/platsmp.c |    1 -
 arch/arm/mach-keystone/smc.S     |    5 ++---
 5 files changed, 26 insertions(+), 16 deletions(-)

Regards,
Santosh
-- 
1.7.9.5
