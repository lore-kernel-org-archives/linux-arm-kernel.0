From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 26 Sep 2011 11:40:49 +0100
Subject: [RFC PATCH 01/14] ARM: GIC: Add global gic_handle_irq() function
In-Reply-To: <20110923201802.GS17169@n2100.arm.linux.org.uk>
References: <1316796692-15964-1-git-send-email-marc.zyngier@arm.com>
	<1316796692-15964-2-git-send-email-marc.zyngier@arm.com>
	<20110923201802.GS17169@n2100.arm.linux.org.uk>
Message-ID: <4E8056B1.4020905@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/09/11 21:18, Russell King - ARM Linux wrote:
> On Fri, Sep 23, 2011 at 05:51:19PM +0100, Marc Zyngier wrote:
>> +		if (irqnr < 16) {
>> +			writel_relaxed(irqstat, gic_cpu_base_addr + GIC_CPU_EOI);
>> +#ifdef CONFIG_SMP
>> +			do_IPI(irqnr, regs);
>> +#endif
> 
> This doesn't work.  do_IPI is marked as an entry function, and so expects
> to be called with the precondition that the pt_regs are stored immediately
> above its stack frame, without another function's stack frame in the way.
> 

Good point. I'll add a handle_IPI() function, modeled after handle_IRQ().

Thanks for pointing this out.

	M.
-- 
Jazz is not dead. It just smells funny...
