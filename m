From: wangyijing@huawei.com (Yijing Wang)
Date: Thu, 11 Sep 2014 09:27:10 +0800
Subject: [Xen-devel] [PATCH v1 08/21] x86/xen/MSI: Use MSI chip framework
 to configure MSI/MSI-X irq
In-Reply-To: <54104641.7020007@citrix.com>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>	<1409911806-10519-9-git-send-email-wangyijing@huawei.com>	<5409C8C0.8020200@citrix.com>
 <540E6095.8030409@huawei.com> <54104641.7020007@citrix.com>
Message-ID: <5410FA6E.8080708@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/9/10 20:38, David Vrabel wrote:
> On 09/09/14 03:06, Yijing Wang wrote:
>> On 2014/9/5 22:29, David Vrabel wrote:
>>> On 05/09/14 11:09, Yijing Wang wrote:
>>>> Use MSI chip framework instead of arch MSI functions to configure
>>>> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
>>> [...]
>>>> --- a/arch/x86/pci/xen.c
>>>> +++ b/arch/x86/pci/xen.c
>>> [...]
>>>> @@ -418,9 +430,9 @@ int __init pci_xen_init(void)
>>>>  #endif
>>>>  
>>>>  #ifdef CONFIG_PCI_MSI
>>>> -	x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
>>>> -	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
>>>> -	x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
>>>> +	xen_msi_chip.setup_irqs = xen_setup_msi_irqs;
>>>> +	xen_msi_chip.teardown_irqs = xen_teardown_msi_irqs;
>>>> +	x86_msi_chip = &xen_msi_chip;
>>>>  	msi_chip.irq_mask = xen_nop_msi_mask;
>>>>  	msi_chip.irq_unmask = xen_nop_msi_mask;
>>>
>>> Why have these not been changed to set the x86_msi_chip.mask/unmask
>>> fields instead?
>>
>> Hi David, x86_msi_chip here is struct msi_chip data type, used to configure MSI/MSI-X
>> irq. msi_chip above is struct irq_chip data type, represent the MSI irq controller. They are
>> not the same object. Their name easily confusing people.
> 
> Ok, it all makes sense now.
> 
> Acked-by: David Vrabel <david.vrabel@citrix.com>

Thanks!

> 
> David
> 
> .
> 


-- 
Thanks!
Yijing
