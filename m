From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 6 Jul 2016 14:15:53 +0800
Subject: [PATCH v4 0/2] make arm_cpuidle_suspend() a bit more efficient
Message-ID: <1467785755-3488-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's one corner case need to be fixed: !cpuidle_ops[cpu].init.
patch1 tries to address this corner case.

patch2 tries to improve arm_cpuidle_suspend() a bit by moving .suspend
check into arm_cpuidle_read_ops().

Since v3:
 - rebased on 4.7-rc1

Since v2:
 - add back patch1.

Since v1:
 - drop patch1, I.E "ARM: cpuidle: fix !cpuidle_ops[cpu].init case
   during init", because there may be platforms which doesn't need the
   init member at all.
 - adopt Daniel's suggestion to move the cpuidle_ops.suspend check to
   arm_cpuidle_read_ops().


Jisheng Zhang (2):
  ARM: cpuidle: fix !cpuidle_ops[cpu].init case during init
  ARM: cpuidle: make arm_cpuidle_suspend() a bit more efficient

 arch/arm/kernel/cpuidle.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

-- 
2.8.1
