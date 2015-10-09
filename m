From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 9 Oct 2015 17:55:01 +0100
Subject: [RFC PATCH v6 2/3] arm64: fix a migrating irq bug when hotplug cpu
In-Reply-To: <1443087135-17044-3-git-send-email-yangyingliang@huawei.com>
References: <1443087135-17044-1-git-send-email-yangyingliang@huawei.com>
 <1443087135-17044-3-git-send-email-yangyingliang@huawei.com>
Message-ID: <20151009165501.GY17192@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2015 at 05:32:14PM +0800, Yang Yingliang wrote:
> When cpu is disabled, all irqs will be migratged to another cpu.
> In some cases, a new affinity is different, the old affinity need
> to be updated and if irq_set_affinity's return value is IRQ_SET_MASK_OK_DONE,
> the old affinity can not be updated. Fix it by using irq_do_set_affinity.
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

I queued this patch for 4.4, on top of this branch from Thomas:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/for-arm

The arm (32-bit) patch would need to go via Russell's tree (patch
system, pull request or waiting until 4.4-rc1, it's up to Russell).

Thanks.

-- 
Catalin
