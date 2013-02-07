From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 7 Feb 2013 08:46:06 -0700
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <20130207112459.5f382ad4@skate>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <5106F9F9.3010905@wwwdotorg.org> <20130129094143.1aad9377@skate>
 <20130129092006.GA16377@avionic-0098.mockup.avionic-design.de>
 <20130207112459.5f382ad4@skate>
Message-ID: <CAErSpo7UOTGH7kjYBADymDdgmHwPxbXqczeXm1BH9C+XViQDRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 7, 2013 at 3:24 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Thierry Reding,
>
> On Tue, 29 Jan 2013 10:20:06 +0100, Thierry Reding wrote:
>
>> > I didn't test recently, but with my first version of the patch set,
>> > having an initialization as late as module_init() was too late. Some
>> > PCI fixup code was being executed *before* we get the opportunity of
>> > initializing the PCI driver, and it was crashing the kernel. I can
>> > provide more details if you want.
>>
>> Does this patch perhaps fix this crash?
>>
>>       http://patchwork.ozlabs.org/patch/210870/
>
> I investigated a bit more, and managed to reproduce my crash even with
> your patch applied. And indeed, my crash is really unrelated to the
> pcibios function disappearing. Here is the kernel panic (and a short
> analysis afterwards) :

Hi Thomas,

Can you post the entire dmesg log, ideally with CONFIG_PCI_DEBUG=y?
That should have more information about the enumeration process,
including what we think the XHCI BARs are and the apertures leading to
them.

The PCI core assumes that we know the host bridge apertures up front,
and I'm not sure that is true on your platform, so maybe we'll need
some changes to accommodate that.

Bjorn
