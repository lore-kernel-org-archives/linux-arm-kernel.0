From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 7 Feb 2013 11:30:32 -0700
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <20130207181559.GA31508@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <5106F9F9.3010905@wwwdotorg.org> <20130129094143.1aad9377@skate>
 <20130129092006.GA16377@avionic-0098.mockup.avionic-design.de>
 <20130207112459.5f382ad4@skate>
 <CAErSpo7UOTGH7kjYBADymDdgmHwPxbXqczeXm1BH9C+XViQDRQ@mail.gmail.com>
 <20130207170020.289bac08@skate>
 <CAErSpo797rhH=xt2x7eqdu7Vwf43FXoXQVcypvHM8-54LRC0wQ@mail.gmail.com>
 <20130207181559.GA31508@obsidianresearch.com>
Message-ID: <CAErSpo58wLV6JXKrVdVH4X=p6X=U=o0czDSAtqWCtxvJbosaEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 7, 2013 at 11:15 AM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Thu, Feb 07, 2013 at 11:08:45AM -0700, Bjorn Helgaas wrote:
>
>> I think the way you'll have to fix this in the meantime is to use
>> pci_create_root_bus() directly so you can do things in this sequence:
>>
>>   pci_create_root_bus
>>   pci_scan_child_bus
>>   pci_bus_assign_resources
>>   pci_bus_add_devices
>>
>> dino_probe() is an example of similar code that does this.
>
> Erm, but isn't this problem going to strike any system that doesn't
> have resources assigned by the firmware?
>
> If so, a common 'pci_scan_bus_from_scratch' would at least highlight
> the problem and centralize the work around until it is fixed...
>
> Many embedded systems will require this..

Yep, agreed on all counts.
