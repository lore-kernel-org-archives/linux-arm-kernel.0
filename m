From: bhelgaas@google.com (Bjorn Helgaas)
Date: Wed, 5 Nov 2014 21:10:59 -0700
Subject: [Patch Part2 v4 21/31] PCI/MSI: enhance PCI MSI core to support
 hierarchy irqdomain
In-Reply-To: <545AD5B3.60009@huawei.com>
References: <1415102525-9898-1-git-send-email-jiang.liu@linux.intel.com>
 <1415102525-9898-22-git-send-email-jiang.liu@linux.intel.com>
 <20141105230952.GH6168@google.com> <545AD5B3.60009@huawei.com>
Message-ID: <CAErSpo5PNAQ40-AQZiz_RTU0JKnSAVXO2Wz=XPQ7aMWjm-iaNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 5, 2014 at 6:58 PM, Yijing Wang <wangyijing@huawei.com> wrote:

>>> +{
>>> +    return (irq_hw_number_t)msidesc->msi_attrib.entry_nr |
>>> +            PCI_DEVID(pdev->bus->number, pdev->devfn) << 11 |
>>> +            (pci_domain_nr(pdev->bus) & 0xFFFFFFFF) << 27;
>>
>> Where does this bit layout come from?  Is this defined in the spec
>> somewhere?  A reference would help.
>
> Currently, more and more Non-PCI device use MSI(or similar MSI mechanism), like DMAR fault irq
> and HPET FSB irq. And we have to add additional code to support the MSI capability.
> So I hope we can decouple MSI code and PCI code, then we can unify all MSI(or Message Based interrupt)
> in one framework.

Was that supposed to answer my question?  If so, I didn't understand
how it explains where the bit layout came from.

Bjorn
