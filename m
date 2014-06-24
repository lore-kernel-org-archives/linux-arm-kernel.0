From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue, 24 Jun 2014 18:14:27 +0200
Subject: [PATCH v3 3/7] irqchip: atmel-aic: add new atmel AIC driver
In-Reply-To: <20140624125653.GN10202@titan.lakedaemon.net>
References: <1403276487-8792-1-git-send-email-boris.brezillon@free-electrons.com>
 <1403276487-8792-4-git-send-email-boris.brezillon@free-electrons.com>
 <53A74316.5080509@free-electrons.com>
 <20140624125653.GN10202@titan.lakedaemon.net>
Message-ID: <53A9A3E3.5020409@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jason,

On 24/06/2014 14:56, Jason Cooper wrote:
> Boris,
>
> On Sun, Jun 22, 2014 at 10:56:54PM +0200, Boris BREZILLON wrote:
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
>> [...]
>>
>>> +
>>> +static int at91_aic_common_irq_domain_xlate(struct irq_domain *d,
>> This function should be named aic_common_irq_domain_xslate to be
>> consistent with other function names.
>> I'll fix that for the next version.
> Other than this one change, this series looks good wrt to irqchip.  When
> you respin, please adjust the patch subject lines like so:
>
>   irqchip: atmel-aic: Add new atmel AIC driver
>
> Note the capitalization.  Also, if you could add Thomas' Ack to the
> first patch, that would be appreciated.

Sure, I'll fix the commit message and add Thomas' ack.

>
> Once you post the new series, I assume it's ok to apply patches 1-3 to
> irqchip/core, or are there some dependency considerations?

Patches 6 and 7 depend on the 3 first patches, but we should be able to
merge them through the at91/arm-soc tree (Nicolas might have to rebase
its tree for 3.17 on irqchip/core after you have applied patches 1-3).

Anyway, I'd like to wait for at91 maintainers/developers reviews before
posting a new version.

Thanks for your support on this series.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
