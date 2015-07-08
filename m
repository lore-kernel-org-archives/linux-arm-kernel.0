From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 8 Jul 2015 20:51:06 +0800
Subject: [PATCH v2 0/2] arm: kernel: implement cpuidle_ops with psci backend
Message-ID: <1436359868-6176-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We'd like to use cpuidle-arm.c for both arm and arm64 with psci as backend.
For arm64, it works. But for arm, we miss cpuidle_ops, these patches try to
address this issue.

Has been tested on Marvell Berlin SoCs. These patches are rebased on the Mark
Rutland's latest psci unification work and Lorenzo Pieralisi's psci related
work[1].

[PATCH 1/2] move psci's cpu_suspend handling to generic code as suggested
	    by Lorenzo.
[PATCH 2/2] implement cpuidle_ops with psci finally.

Since v1:
 - add a new file psci_cpuidle.c to implment cpuidle_ops

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/347352.html

Jisheng Zhang (2):
  firmware: psci: move cpu_suspend handling to generic code
  arm: kernel: implement cpuidle_ops with psci backend

 arch/arm/kernel/Makefile       |  1 +
 arch/arm/kernel/psci_cpuidle.c | 29 +++++++++++++
 arch/arm64/kernel/psci.c       | 95 ------------------------------------------
 drivers/firmware/psci.c        | 95 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/psci.h           |  2 +
 5 files changed, 127 insertions(+), 95 deletions(-)
 create mode 100644 arch/arm/kernel/psci_cpuidle.c

-- 
2.1.4
