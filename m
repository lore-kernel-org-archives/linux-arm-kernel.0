From: bhelgaas@google.com (Bjorn Helgaas)
Date: Wed, 5 Nov 2014 22:28:55 -0700
Subject: [Patch Part2 v4 21/31] PCI/MSI: enhance PCI MSI core to support
 hierarchy irqdomain
In-Reply-To: <545AFFF1.5030509@linux.intel.com>
References: <1415102525-9898-1-git-send-email-jiang.liu@linux.intel.com>
 <1415102525-9898-22-git-send-email-jiang.liu@linux.intel.com>
 <20141105230952.GH6168@google.com> <545AFFF1.5030509@linux.intel.com>
Message-ID: <CAErSpo4JYzSQJQkRTaK-M18RVXaLKX-0yoAm853tu2NJypiL9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 5, 2014 at 9:58 PM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
> On 2014/11/6 7:09, Bjorn Helgaas wrote:
>> On Tue, Nov 04, 2014 at 08:01:55PM +0800, Jiang Liu wrote:

>>> +{
>>> +    return (irq_hw_number_t)msidesc->msi_attrib.entry_nr |
>>> +            PCI_DEVID(pdev->bus->number, pdev->devfn) << 11 |
>>> +            (pci_domain_nr(pdev->bus) & 0xFFFFFFFF) << 27;
>>
>> Where does this bit layout come from?  Is this defined in the spec
>> somewhere?  A reference would help.
> We need a unique number to identify every possible MSI source,
> and this ID number is only used within the irqdomain subsystem.
> So we used above algorithm to generate the ID number, there's
> no specification for it.

A comment to that effect would be great.

Bjorn
