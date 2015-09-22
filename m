From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 22 Sep 2015 19:50:37 +0100
Subject: [RFC PATCH v5 4/4] arm: fix a migrating irq bug when hotplug cpu
In-Reply-To: <1442631959-10228-5-git-send-email-yangyingliang@huawei.com>
References: <1442631959-10228-1-git-send-email-yangyingliang@huawei.com>
 <1442631959-10228-5-git-send-email-yangyingliang@huawei.com>
Message-ID: <20150922195037.472b404c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 19 Sep 2015 11:05:59 +0800
Yang Yingliang <yangyingliang@huawei.com> wrote:

> When cpu is disabled, all irqs will be migratged to another cpu.
> In some cases, a new affinity is different, it needed to be coppied
> to irq's affinity. But if the type of irq is LPI, it's affinity will
> not be coppied because of irq_set_affinity's return value. Fix it by
> using irq_do_set_affinity.
> 
> And migrating interrupts is a core code matter, so use the generic
> function irq_migrate_all_off_this_cpu() to migrate interrupts in
> kernel/irq/migration.c.
> 
> Cc: Jiang Liu <jiang.liu@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
