From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Aug 2017 14:55:51 +0100
Subject: [PATCH] irqchip/armada-370-xp: Enable MSI-X support
In-Reply-To: <20170815134255.GB31762@io.lakedaemon.net>
References: <20170502072600.13380-1-sr@denx.de>
 <80f30724-20b6-b5a7-7218-93ff3fa23177@denx.de>
 <20170815134255.GB31762@io.lakedaemon.net>
Message-ID: <9d7c9cd5-468b-1fe6-e50b-9b968b157b8b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/08/17 14:42, Jason Cooper wrote:
> + Marc ;-)

Thanks Jason.

> 
> On Tue, Aug 15, 2017 at 03:31:31PM +0200, Stefan Roese wrote:
>> On 02.05.2017 09:26, Stefan Roese wrote:
>>> Armada XP does not only support MSI, but also MSI-X. This patch sets
>>> the MSI_FLAG_PCI_MSIX flag in the interrupt controller driver which
>>> is the only change necessary to enable MSI-X support on this SoC. As
>>> the Linux PCI MSI-X infrastructure takes care of writing the data and
>>> address structures into the BAR specified by the MSI-X controller.
>>>
>>> Signed-off-by: Stefan Roese <sr@denx.de>
>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>>> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>> Cc: Jason Cooper <jason@lakedaemon.net>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> ---
>>>  drivers/irqchip/irq-armada-370-xp.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
>>> index 33982cbd8a57..b17039ed8735 100644
>>> --- a/drivers/irqchip/irq-armada-370-xp.c
>>> +++ b/drivers/irqchip/irq-armada-370-xp.c
>>> @@ -124,7 +124,7 @@ static struct irq_chip armada_370_xp_msi_irq_chip = {
>>>  static struct msi_domain_info armada_370_xp_msi_domain_info = {
>>>  	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>>> -		   MSI_FLAG_MULTI_PCI_MSI),
>>> +		   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
>>>  	.chip	= &armada_370_xp_msi_irq_chip,
>>>  };
>>>
>>
>> Its been a while since this patch has been submitted - without any
>> comments so far. What's the current status with it? Is it someones
>> queue for upstreaming?
> 
> I'd like to see an Ack from Thomas P, as he's intimately familiar with
> both the platforms and the PCI support.
Same here. If Thomas P is OK with it, I'll queue it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
