From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 27 Jul 2015 12:02:22 +0100
Subject: [PATCH v2 3/4] ARM: mvebu: Allow using the GIC for wakeup in
 standby mode
In-Reply-To: <20150701175436.7dff0754@free-electrons.com>
References: <1435684740-24912-1-git-send-email-gregory.clement@free-electrons.com>
 <1435684740-24912-4-git-send-email-gregory.clement@free-electrons.com>
 <20150701175436.7dff0754@free-electrons.com>
Message-ID: <55B60FBE.7060606@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas/Gregory,

On 01/07/15 16:54, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
>
> On Tue, 30 Jun 2015 19:18:59 +0200, Gregory CLEMENT wrote:
>
>>   static void __init mvebu_init_irq(void)
>>   {
>> +	if (of_machine_is_compatible("marvell,armada375") ||
>> +	    of_machine_is_compatible("marvell,armada380") ||
>> +	    of_machine_is_compatible("marvell,armada390"))
>
> What we really want to know is if we're using the GIC, so what about
> instead:
>
> 	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-gic");
> 	if (np)
> 		gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE |
> 				      IRQCHIP_MASK_ON_SUSPEND);

As I had mentioned before, this function was planned to be removed. tglx
has now pulled in the patch into tip/core[1]. If this patch is already
pulled in, it's better to revert so that it won't break the build in
linux-next. Since the flags are now moved to GIC driver, this patch is
no longer required. Sorry for the trouble.

Regards,
Sudeep

[1] 
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=irq/core&id=0d3f2c92e004c67404fabea19728c1962b777bd6
