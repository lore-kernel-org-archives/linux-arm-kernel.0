From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 16 Mar 2018 16:39:47 +0000
Subject: [PATCH 0/2] irqchip/gic*: Complain about the use of IRQ_TYPE_NONE
In-Reply-To: <5f274a06-3a9c-7d41-2e4d-9733e4ac6078@arm.com>
References: <20180316145511.28362-1-marc.zyngier@arm.com>
 <5f274a06-3a9c-7d41-2e4d-9733e4ac6078@arm.com>
Message-ID: <399d5e06-c530-6a29-8a4d-9e8ca62167c4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/03/18 16:19, Robin Murphy wrote:
> On 16/03/18 14:55, Marc Zyngier wrote:
>> Grepping through the dts files, the documentation, and reviewing
>> patches, one can only notice the use of IRQ_TYPE_NONE in interrupt
>> specifiers. At least for the GIC, this doesn't mean anything. The
>> unsuspecting driver will end-up with whatever was there before, and
>> there is a 50% probability that it is not what it wants.
>>
>> I'd love to fix it myself, but I also have a 50% probability of
>> getting it wrong. In order to make the user aware they are walking on
>> thin ice, let's add some warnings. Hopefully, they'll be annoying
>> enough that people will fix their firmware. Croudsourcing debugging...
> 
> I guess there's also the alternative nuclear option of breaking their 
> build ;)
> 
> Robin.
> 
> ----->8-----
> diff --git a/include/dt-bindings/interrupt-controller/irq.h 
> b/include/dt-bindings/interrupt-controller/irq.h
> index a8b310555f14..de79af80d01e 100644
> --- a/include/dt-bindings/interrupt-controller/irq.h
> +++ b/include/dt-bindings/interrupt-controller/irq.h
> @@ -10,7 +10,7 @@
>   #ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_IRQ_H
>   #define _DT_BINDINGS_INTERRUPT_CONTROLLER_IRQ_H
> 
> -#define IRQ_TYPE_NONE		0
> +#define IRQ_TYPE_NONE		"This is nonsense and needs fixing"
>   #define IRQ_TYPE_EDGE_RISING	1
>   #define IRQ_TYPE_EDGE_FALLING	2
>   #define IRQ_TYPE_EDGE_BOTH	(IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING)
> 

What really annoys me with this patch is that you haven't put a SoB on it...

	M.
-- 
Jazz is not dead. It just smells funny...
