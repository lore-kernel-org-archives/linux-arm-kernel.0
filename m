From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 1 Oct 2015 16:24:24 +0200 (CEST)
Subject: [tip:irq/core] genirq: Introduce generic irq migration for cpu
 hotunplug
In-Reply-To: <tip-f1e0bb0ad473a32d1b7e6d285ae9f7e47710bb5e@git.kernel.org>
References: <1443087135-17044-2-git-send-email-yangyingliang@huawei.com>
 <tip-f1e0bb0ad473a32d1b7e6d285ae9f7e47710bb5e@git.kernel.org>
Message-ID: <alpine.DEB.2.11.1510011619390.4500@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Oct 2015, tip-bot for Yang Yingliang wrote:

> Commit-ID:  f1e0bb0ad473a32d1b7e6d285ae9f7e47710bb5e
> Gitweb:     http://git.kernel.org/tip/f1e0bb0ad473a32d1b7e6d285ae9f7e47710bb5e
> Author:     Yang Yingliang <yangyingliang@huawei.com>
> AuthorDate: Thu, 24 Sep 2015 17:32:13 +0800
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Thu, 1 Oct 2015 14:51:15 +0200
> 
> genirq: Introduce generic irq migration for cpu hotunplug
> 
> ARM and ARM64 have almost identical code for migrating interrupts on
> cpu hotunplug. Provide a generic version which can be used by both.
> 
> The new code addresses a shortcoming in the ARM[64] variants which
> fails to update the affinity change in some cases. The solution for
> this is to use the core function irq_do_set_affinity() instead of open
> coding it.
> 
> [ tglx: Added copyright notice and license boilerplate. Rewrote
>   	subject and changelog. ]
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Acked-by: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Cc: Jiang Liu <jiang.liu@linux.intel.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Link: http://lkml.kernel.org/r/1443087135-17044-2-git-send-email-yangyingliang at huawei.com
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Russell, Will,

I applied that to a seperate branch

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/for-arm

You can pull that into arm[64] so you can apply the architecture
specific part.

Thanks,

	tglx
