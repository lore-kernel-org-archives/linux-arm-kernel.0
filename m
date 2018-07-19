From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Thu, 19 Jul 2018 11:42:50 +0200
Subject: arm: v4.18-rc5 with cpuidle on TC2 (A7 boot) spectre v2 issue
Message-ID: <2abc6c11-2e8c-a4ea-6911-0f495d90ace6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

running v4.18-rc5 (plus still missing "power: vexpress: fix corruption 
in notifier registration", otherwise I get this rcu_sched stall issue) 
on TC2 (A7 boot) with vanilla multi_v7_defconfig plus 
CONFIG_ARM_BIG_LITTLE_CPUIDLE=y gives me continuous:

...
  CPUX: Spectre v2: incorrect context switching function, system vulnerable
...

messages.

Work around is to disable CONFIG_HARDEN_BRANCH_PREDICTOR.

-- Dietmar
