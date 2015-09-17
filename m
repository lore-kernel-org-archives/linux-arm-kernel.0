From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Sep 2015 17:01:07 +0100
Subject: [RFC PATCH v4 3/4] arm64: fix a migrating irq bug when hotplug cpu
In-Reply-To: <1442467166-1460-4-git-send-email-yangyingliang@huawei.com>
References: <1442467166-1460-1-git-send-email-yangyingliang@huawei.com>
 <1442467166-1460-4-git-send-email-yangyingliang@huawei.com>
Message-ID: <20150917160107.GO25634@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2015 at 06:19:25AM +0100, Yang Yingliang wrote:
> When cpu is disabled, all irqs will be migratged to another cpu.
> In some cases, a new affinity is different, it needed to be coppied
> to irq's affinity. But if the type of irq is LPI, it's affinity will
> not be coppied because of irq_set_affinity's return value. Fix it by
> using irq_do_set_affinity.
> 
> And migrating interrupts is a core code matter, so use the generic
> function move_irqs() to migrate interrupts in kernel/irq/migration.c.
> 
> Cc: Jiang Liu <jiang.liu@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  arch/arm64/Kconfig           |  1 +
>  arch/arm64/include/asm/irq.h |  1 -
>  arch/arm64/kernel/irq.c      | 62 --------------------------------------------
>  arch/arm64/kernel/smp.c      |  2 +-
>  4 files changed, 2 insertions(+), 64 deletions(-)

Removing code is always good, so:

  Acked-by: Will Deacon <will.deacon@arm.com>

but obviously this depends on the core stuff.

Will
