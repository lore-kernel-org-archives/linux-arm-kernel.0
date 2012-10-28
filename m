From: robherring2@gmail.com (Rob Herring)
Date: Sun, 28 Oct 2012 08:30:01 -0500
Subject: [PATCH v2 1/4] irqchip: add basic infrastructure
In-Reply-To: <20121028142408.7512671c@skate>
References: <1351416634-3352-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1351416634-3352-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <508D30B2.6070806@gmail.com> <20121028142408.7512671c@skate>
Message-ID: <508D3359.6000309@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2012 08:24 AM, Thomas Petazzoni wrote:
> Rob,
> 
> On Sun, 28 Oct 2012 08:18:42 -0500, Rob Herring wrote:
> 
>>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>>> index 1bb8bf6..e0ff166 100644
>>> --- a/drivers/irqchip/Kconfig
>>> +++ b/drivers/irqchip/Kconfig
>>> @@ -1 +1,2 @@
>>> -# empty
>>> +config USE_IRQCHIP
>>> +	bool
>>
>> This should depend on OF_IRQ.
> 
> It is correct that the mechanism only works for irqchip drivers that
> are probed through the Device Tree. However, having a "depends on"
> inside a configuration that gets "select"ed by other configuration
> options (in our case ARCH_BCM2835 and ARCH_MVEBU select USE_IRQCHIP) is
> useless: kconfig doesn't care of the "depends on" dependencies when
> you're "select"ing an option.
> 
> So, I can add it for documentation purposes, but it is practically
> useless.

It will give a kconfig error rather than build error on of_irq_init
which would result in patches for empty of_irq_init.

How about default y and depends on OF_IRQ. Then you don't need a select.
I think we want all DT enabled platforms to use this and it's only a
small amount of init space.

Rob

> 
> Best regards,
> 
> Thomas
> 
