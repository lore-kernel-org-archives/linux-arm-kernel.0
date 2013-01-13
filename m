From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Sun, 13 Jan 2013 10:12:45 -0800
Subject: Build error on kernel/rcutree.c
In-Reply-To: <CAOMZO5ASEY6iHQ1UekR88vWZPutsJdiEuGkpsC2Civ6ezi2NGg@mail.gmail.com>
References: <CAOMZO5ASEY6iHQ1UekR88vWZPutsJdiEuGkpsC2Civ6ezi2NGg@mail.gmail.com>
Message-ID: <20130113181245.GK3384@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 13, 2013 at 04:03:24PM -0200, Fabio Estevam wrote:
> Hi Paul,
> 
> When building ARM imx_v4_v5_defconfig the following error shows up on
> linux-next 20130111:
> 
> kernel/rcutree.c:808:2: error: implicit declaration of function
> 'rcu_jiffies_till_stall_check' [-Werror=implicit-function-declaration]
> kernel/rcutree.c:941:6: error: 'rcu_cpu_stall_suppress' undeclared
> (first use in this function)
> 
> Is this a known issue?

Yes, the fix is in -rcu and should make it to -next soon.

In the meantime, you can work around the problem by avoiding selecting
CONFIG_TREE_PREEMPT_RCU=y on SMP=n builds -- use CONFIG_TINY_PREEMPT_RCU
instead.

							Thanx, Paul
