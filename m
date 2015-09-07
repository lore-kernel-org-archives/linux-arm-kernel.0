From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 07 Sep 2015 13:32:18 +0100
Subject: [RFC PATCH v1 2/4] irqchip: GICv3: set non-percpu irqs status
 with _IRQ_MOVE_PCNTXT
In-Reply-To: <55EBD59B.4030405@linux.intel.com>
References: <1441513421-8092-1-git-send-email-yangyingliang@huawei.com>
 <1441513421-8092-3-git-send-email-yangyingliang@huawei.com>
 <55EBD59B.4030405@linux.intel.com>
Message-ID: <55ED83D2.90809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/15 06:56, Jiang Liu wrote:
> On 2015/9/6 12:23, Yang Yingliang wrote:
>> Use irq_settings_set_move_pcntxt() helper irqs status with
>> _IRQ_MOVE_PCNTXT. So that it can do set affinity when calling
>> irq_set_affinity_locked().
> Hi Yingliang,
> 	We could only set _IRQ_MOVE_PCNTCT flag to enable migrating
> IRQ in process context if your hardware platform supports atomically
> change IRQ configuration. Not sure whether that's true for GICv3.
> If GICv3 doesn't support atomically change irq configuration, this
> change may cause trouble.

I think it boils down to what exactly "process context" means here. If
this means "we do not need to mask the interrupt" while moving it, then
it should be fine (the GIC architecture guarantees that a pending
interrupt will be migrated).

Is there any other requirement for this flag?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
