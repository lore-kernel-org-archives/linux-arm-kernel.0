From: tghk48@motorola.com (TAO HU)
Date: Wed, 12 Jan 2011 17:04:43 +0800
Subject: [RFC] ARM: Let GIC to route IRQs to any allowed CPUs
In-Reply-To: <20110112085110.GR11039@n2100.arm.linux.org.uk>
References: <AANLkTimNMcs_6-NMTSY+yZuDUSB2eC2R_NX35gq00f7E@mail.gmail.com>
	<20110112085110.GR11039@n2100.arm.linux.org.uk>
Message-ID: <AANLkTim3BUvnMsH=oW1cxmzT2wmwpxPFLjrP39TGbuhx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Russell King

Thanks.

For "The result will be CPUs fighting over servicing such interrupts."
What's the consequence? The performance downgrade?

Does it imply a design flaw in GIC or in ARM SMP?

On Wed, Jan 12, 2011 at 4:51 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jan 12, 2011 at 04:18:51PM +0800, TAO HU wrote:
>> The current logic will always route IRQs to the first allowed CPU
>> Following two commands have the same result (all IRQs to CPU0)
>> cmd1: $ echo 3 > proc/irq/xxx/smp_affinity
>> cmd2: $ echo 1 > proc/irq/xxx/smp_affinity
>> While below command will route all IRQs to CPU1
>> cmd3: $ echo 2 > proc/irq/xxx/smp_affinity
>>
>> With this patch, cmd1 will route IRQs to both CPU0 and CPU1
>> Meanwhile, cmd2 and cmd3 will work as before
>
> There's a reason we don't do this...
>
> We don't want to deliver one IRQ to both CPU0 and CPU1 at the same time,
> which is what will happen with this patch. ?The GIC hardware doesn't
> do IRQ balancing between CPUs.
>
> The result will be CPUs fighting over servicing such interrupts.
>



-- 
Best Regards
Hu Tao
