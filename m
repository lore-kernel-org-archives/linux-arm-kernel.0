From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 14 Apr 2016 09:56:59 +0100
Subject: [PATCH v2] sunxi-irq: Fix Kconfig dependency on GENERIC_IRQ_CHIP
In-Reply-To: <570F5932.2020809@arm.com>
References: <1460563167-18517-1-git-send-email-suzuki.poulose@arm.com>
 <20160413200735.GC4005@lukather> <570F5932.2020809@arm.com>
Message-ID: <570F5B5B.90302@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/04/16 09:47, Suzuki K Poulose wrote:
> On 13/04/16 21:07, Maxime Ripard wrote:
>> Hi,
>>
>> On Wed, Apr 13, 2016 at 04:59:27PM +0100, Suzuki K Poulose wrote:
>>> The sunxi-nmi and sun4i irq chips are selected by ARCH_SUNXI on both arm
>>> and arm64 (recently added). However on arm64, we don't explicitly select
>>> GENERIC_IRQ_CHIP which is required by the sunxi-nmi irq chip driver and
>>> causes build breaks on 4.6-rc1 :
>
>>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>>> index b03cfcb..c9626f4 100644
>>> --- a/drivers/irqchip/Makefile
>>> +++ b/drivers/irqchip/Makefile
>>> @@ -19,8 +19,8 @@ obj-$(CONFIG_CLPS711X_IRQCHIP)        += irq-clps711x.o
>>>   obj-$(CONFIG_OR1K_PIC)            += irq-or1k-pic.o
>>>   obj-$(CONFIG_ORION_IRQCHIP)        += irq-orion.o
>>>   obj-$(CONFIG_OMAP_IRQCHIP)        += irq-omap-intc.o
>>> -obj-$(CONFIG_ARCH_SUNXI)        += irq-sun4i.o
>>> -obj-$(CONFIG_ARCH_SUNXI)        += irq-sunxi-nmi.o
>>> +obj-$(CONFIG_SUNXI_IRQCHIP)        += irq-sun4i.o
>>> +obj-$(CONFIG_SUNXI_IRQCHIP)        += irq-sunxi-nmi.o
>>
>> Those are two different drivers, that should be selected by different
>> SoCs (MACH_SUN4I and MACH_SUN5I for the former, SUN6I, SUN7I and SUN8I
>> for the latter)
>
> OK. I had thought about that, but wasn't sure who needs what. So went with
> what existed already. I can respin it.

As a follow up question, what does the arm64 port need ? just sunxi-nmi ? or both ?
I would be happy if someone who has better understanding of the dependencies can fix
it up, rather than me trying to figure out all the dependencies.

Cheers
Suzuki
