From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 8 Jul 2015 18:13:33 +0800
Subject: [PATCH 0/4] arm: psci: implement cpuidle_ops
Message-ID: <1436350417-6712-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We'd like to use cpuidle-arm.c for both arm and arm64 with psci as backend.
For arm64, it works. But for arm, we miss cpuidle_ops, these patches try to
address this issue.

Has been tested on Marvell Berlin SoCs. These patches are rebased on the Mark
Rutland's latest psci unification work and Lorenzo Pieralisi's psci related
work[1].

[PATCH 1/4] renames psci_smp.c to psci.c to prepare for the next two changes.
[PATCH 2/4] enables PSCI on UP systems
[PATCH 3/4] move psci's cpu_suspend handling to generic code as suggested
	    by Lorenzo.
[PATCH 4/4] implement cpuidle_ops with psci finally.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/347352.html

Jisheng Zhang (4):
  arm: psci: rename psci_smp.c to psci.c
  arm: psci: enable PSCI on UP systems
  firmware: psci: move cpu_suspend handling to generic code
  arm: psci: add cpuidle_ops support

 arch/arm/kernel/Makefile               |  5 +-
 arch/arm/kernel/{psci_smp.c => psci.c} | 22 ++++++++
 arch/arm64/kernel/psci.c               | 95 ----------------------------------
 drivers/firmware/psci.c                | 95 ++++++++++++++++++++++++++++++++++
 include/linux/psci.h                   |  2 +
 5 files changed, 120 insertions(+), 99 deletions(-)
 rename arch/arm/kernel/{psci_smp.c => psci.c} (86%)

-- 
2.1.4
