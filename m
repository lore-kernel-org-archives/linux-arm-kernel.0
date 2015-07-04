From: jszhang@marvell.com (Jisheng Zhang)
Date: Sat, 4 Jul 2015 21:01:47 +0800
Subject: [RFC PATCH 0/3] arm: psci: implement cpuidle_ops
Message-ID: <1436014910-1201-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We'd like to use cpuidle-arm.c for both arm and arm64 with psci as backend.
For arm64, it works. But for arm, we miss cpuidle_ops, these patches try to
address this issue.

Has been tested on Marvell Berlin SoCs. These patches are rebased on the Mark
Rutland's latest psci unification work.

[PATCH 1/3] renames psci_smp.c to psci.c to prepare for the next two changes.
[PATCH 2/3] enables PSCI on UP systems so that some calls like cpu_suspend can
be made functional on UP too
[PATCH 3/3] add the cpuidle_ops for psci. Most code is stolen from arm64, which
introduce duplicated psci code, that's why it's marked as "RFC", I dunno where
to put cpu_psci_cpu_init_idle() related functions.

Comments are welcome!


Jisheng Zhang (3):
  arm: psci: rename psci_smp.c to psci.c
  arm: psci: enable PSCI on UP systems
  arm: psci: add cpuidle_ops support

 arch/arm/kernel/Makefile   |   5 +-
 arch/arm/kernel/psci.c     | 248 +++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/psci_smp.c | 130 ------------------------
 3 files changed, 249 insertions(+), 134 deletions(-)
 create mode 100644 arch/arm/kernel/psci.c
 delete mode 100644 arch/arm/kernel/psci_smp.c

-- 
2.1.4
