From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 24 Mar 2016 13:11:07 +0800
Subject: [PATCH 0/2] ARM: cpuidle: bug fix and a trivial improvement
Message-ID: <1458796269-6158-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's one corner case need to be fixed: !cpuidle_ops[cpu].init.
patch1 tries to address this corner case.

patch2 tries to improve arm_cpuidle_suspend() a bit by moving .suspend
check into arm_cpuidle_init().

Jisheng Zhang (2):
  ARM: cpuidle: fix !cpuidle_ops[cpu].init case during init
  ARM: cpuidle: make arm_cpuidle_suspend() a bit more efficient

 arch/arm/kernel/cpuidle.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

-- 
2.8.0.rc3
