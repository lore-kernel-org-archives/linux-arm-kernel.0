From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Thu, 23 Jul 2015 13:50:42 +0700
Subject: [RFCv2 PATCH 1/8] irqdomain: Introduce
 irq_domain_ops.init_alloc_info
In-Reply-To: <alpine.DEB.2.11.1507202326450.18576@nanos>
References: <1436778864-17645-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1436778864-17645-2-git-send-email-Suravee.Suthikulpanit@amd.com>
 <alpine.DEB.2.11.1507202326450.18576@nanos>
Message-ID: <55B08EC2.4000204@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 7/21/15 04:28, Thomas Gleixner wrote:
> On Mon, 13 Jul 2015, Suravee Suthikulpanit wrote:
>
>> Currently, when calling irq_domain_alloc_irqs() on ARM64, it uses
>> struct of_phandle_args to pass irq information. However, this is not
>> appropriate for ACPI since of_phandle_args is specific to DT.
>>
>> Therefore, this patch introduces a new function pointer,
>> irq_domain_ops.init_alloc_info, which can be used by irqchips to provide
>> a way to initialize irqchip-specific data-structure for allocating IRQ.
>>
>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> ---
>> NOTE:
>> Similarly, x86 is currently using struct irq_alloc_info
>> (see arch/x86/include/asm/hw_irq.h) and each irq_domain has different
>> way of initializing this structure.
>
> And why don't you use the same mechanism on ARM and have a private
> irq_alloc_info implementation which can carry either DT or ACPI
> information?

Let me look further into this. I would like to take a similar approach here.

Suravee

> Thanks,
>
> 	tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
