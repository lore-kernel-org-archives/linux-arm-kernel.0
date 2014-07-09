From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 9 Jul 2014 18:38:00 +0200
Subject: [PATCH v3 3/7] irqchip: atmel-aic: add new atmel AIC driver
In-Reply-To: <20140626203007.GU10202@titan.lakedaemon.net>
References: <1403276487-8792-1-git-send-email-boris.brezillon@free-electrons.com>
 <1403276487-8792-4-git-send-email-boris.brezillon@free-electrons.com>
 <53AC8088.6020905@free-electrons.com>
 <20140626203007.GU10202@titan.lakedaemon.net>
Message-ID: <53BD6FE8.1030704@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/06/2014 22:30, Jason Cooper :
> On Thu, Jun 26, 2014 at 10:20:24PM +0200, Boris BREZILLON wrote:
>>
>> On 20/06/2014 17:01, Boris BREZILLON wrote:
>>> Add new atmel AIC (Advanced Interrupt Controller) driver based on the
>>> generic chip infrastructure.
>>>
>>> This driver is only compatible with dt enabled board and replaces the old
>>> implementation found in arch/arm/mach-at91/irq.c.
>>>
>>> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
>>> ---
>>>  drivers/irqchip/Kconfig         |   7 +
>>>  drivers/irqchip/Makefile        |   1 +
>>>  drivers/irqchip/irq-atmel-aic.c | 700 ++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 708 insertions(+)
>>>  create mode 100644 drivers/irqchip/irq-atmel-aic.c
>>>
>>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>>> index bbb746e..6a7ad81 100644
>>> --- a/drivers/irqchip/Kconfig
>>> +++ b/drivers/irqchip/Kconfig
>>> @@ -30,6 +30,13 @@ config ARM_VIC_NR
>>>  	  The maximum number of VICs available in the system, for
>>>  	  power management.
>>>  
>>> +config ATMEL_AIC_IRQ
>>> +	bool
>>> +	select GENERIC_IRQ_CHIP
>>> +	select IRQ_DOMAIN
>>> +	select MULTI_IRQ_HANDLER
>>> +	select SPARSE_IRQ
>>> +
>>
>> I just though a bit about it and it might be better to split AIC and
>> AIC5 support in 2 different drivers, because the AIC is only available
>> on at91sam9/at91rm9200 SoCs and AIC5 only available on sama5 SoCs, and
>> AFAICT there is no combination of both controller in a singler SoC.
>>
>> Jason, Thomas, let me know if you think this worth the trouble, and if
>> so, should I keep a common implementation (in irq-atmel-aic-common.c/.h)
>> for the shared functions/structures.
> 
> It sounds sensible, and we have a similar situation brewing with the gic
> family.  I'd like to hear from the at91 maintainers, though.

Absolutely Boris and Jason. Re-reading the new AIC code it seems obvious
to split the 2 drivers, now that we have a nice framework in place, no
extra code is needed appart from both form of irq chip implementation.

Let's go this way. And of course, you have on the whole series my:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks, bye,
-- 
Nicolas Ferre
