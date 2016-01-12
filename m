From: ddaney@caviumnetworks.com (David Daney)
Date: Tue, 12 Jan 2016 09:56:03 -0800
Subject: [PATCH V2 11/23] arm64,
 pci: Remove useless boot time IRQ assignment when booting with DT.
In-Reply-To: <56952619.7010602@semihalf.com>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
 <1450278993-12664-12-git-send-email-tn@semihalf.com>
 <20160112135023.GC3601@red-moon> <56952619.7010602@semihalf.com>
Message-ID: <56953E33.6030003@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/2016 08:13 AM, Tomasz Nowicki wrote:
> On 12.01.2016 14:50, Lorenzo Pieralisi wrote:
>> On Wed, Dec 16, 2015 at 04:16:21PM +0100, Tomasz Nowicki wrote:
>>> In order to probe PCIe host controller when booting with DT,
>>> ARM64 is using drivers which defer IRQ assignment to device
>>> enable time. It means that boot time DT specific irq map initialization
>>> is always overridden, so lets remove that code.
>>>
>>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>>> ---
>>>   arch/arm64/kernel/pci.c | 10 ----------
>>>   1 file changed, 10 deletions(-)
>>>
>>> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
>>> index 023b983..f7948f5 100644
>>> --- a/arch/arm64/kernel/pci.c
>>> +++ b/arch/arm64/kernel/pci.c
>>> @@ -51,16 +51,6 @@ int pcibios_enable_device(struct pci_dev *dev, int
>>> mask)
>>>       return pci_enable_resources(dev, mask);
>>>   }
>>>
>>> -/*
>>> - * Try to assign the IRQ number from DT when adding a new device
>>> - */
>>> -int pcibios_add_device(struct pci_dev *dev)
>>> -{
>>> -    dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
>>> -
>>> -    return 0;
>>> -}
>>> -

How was this tested?  Or in other words, what PCI devices that use 
legacy INT{A,B,C,D} interrupts were used in testing this patch?

David Daney


>>
>> Actually, this patch should be part of Matthew's series:
>>
>
> Agree.
>
> Matthew can you please add this patch to your series?
>
> Thanks,
> Tomasz
