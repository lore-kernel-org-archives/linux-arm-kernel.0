From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 29 Sep 2010 14:09:07 +0100
Subject: [PATCH v2] ARM: MM: bugfix: initialize spinlock for
	init_mm.context
In-Reply-To: <1285635990-3036-1-git-send-email-myungjoo.ham@samsung.com>
References: <1285635990-3036-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1285765747.7983.34.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-09-28 at 02:06 +0100, MyungJoo Ham wrote:
> init_mm used at kernel/sched.c:idle_task_exit() has spin_lock
> (init_mm.context.id_lock) that is not initialized when spin_lock/unlock
> is called at an ARM machine. Note that mm_struct.context.id_lock is usually
> initialized except for the instance of init_mm at linux/arch/arm/mm/context.c
> 
> Not initializing this spinlock incurs "BUG: pinlock bad magic" warning when
> spinlock debug is enabled. We have observed such instances when testing PM in
> S5PC210 machines.
> 
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
