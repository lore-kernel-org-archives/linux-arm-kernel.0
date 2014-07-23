From: bhelgaas@google.com (Bjorn Helgaas)
Date: Wed, 23 Jul 2014 10:43:44 -0600
Subject: [PATCH v7 0/5] Add Keystone PCIe controller driver
In-Reply-To: <53CFD444.4010700@ti.com>
References: <1405961925-27248-1-git-send-email-m-karicheri2@ti.com>
 <20140722225708.GB27965@google.com> <53CFD444.4010700@ti.com>
Message-ID: <CAErSpo6gEVP7XbiPZ90MP4zn5mrjaJLZTW0_sdjg9Q6HjnnkFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 23, 2014 at 9:27 AM, Murali Karicheri <m-karicheri2@ti.com> wrote:
>
> Bjorn,
>
>
> On 07/22/2014 06:57 PM, Bjorn Helgaas wrote:
>>
>> On Mon, Jul 21, 2014 at 12:58:40PM -0400, Murali Karicheri wrote:
>
>
>>> Murali Karicheri (5):
>>>    PCI: designware: add rd[wr]_other_conf API
>>>    PCI: designware: refactor MSI code to work with v3.65 dw hardware
>>
>>
>> I applied the above two to my pci/host-designware branch.  The rest didn't
>> apply cleanly because I applied Kishon's DRA7xx changes first, and there
>> are several conflicts.  Can you rebase the rest of them on top of
>> pci/host-designware?
>
>
> Thanks for applying 1 and 2.
>
> I will fix up 3 based on your branch and send you updated patch 3 and 4
> today.  Hope you can apply this updated patch so that I don't have to
> address any rebase issues. Regarding the MRSS comment, I will discuss it on
> that thread and send you a fix for removing the bootargs depedency based on
> what comes out of that discussion. Is that fine?

Yep, sounds reasonable.  I'm about to leave for vacation, so I won't
be able to apply these until mid-August, but I think we can still get
them into v3.17 since it's new hardware that shouldn't affect anything
else.

For MRSS, I'll probably open a bugzilla and reference it in the
changelog just so we don't forget about it.

>>>    PCI: designware: enhance dw_pcie_host_init() to support v3.65 DW
>>>      hardware
>>>    PCI: add PCI controller for keystone PCIe h/w
>>>    PCI: keystone: Update maintainer information
>>
>>
>> You can squash the MAINTAINERS update into the driver addition.  They're
>> logically part of the same change.
>>
>> Bjorn
>>
>>>   .../devicetree/bindings/pci/pci-keystone.txt       |   68 +++
>>>   MAINTAINERS                                        |    7 +
>>>   drivers/pci/host/Kconfig                           |    5 +
>>>   drivers/pci/host/Makefile                          |    1 +
>>>   drivers/pci/host/pci-keystone-dw.c                 |  521
>>> ++++++++++++++++++++
>>>   drivers/pci/host/pci-keystone.c                    |  386
>>> +++++++++++++++
>>>   drivers/pci/host/pci-keystone.h                    |   58 +++
>>>   drivers/pci/host/pcie-designware.c                 |  116 +++--
>>>   drivers/pci/host/pcie-designware.h                 |    9 +
>>>   9 files changed, 1135 insertions(+), 36 deletions(-)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/pci/pci-keystone.txt
>>>   create mode 100644 drivers/pci/host/pci-keystone-dw.c
>>>   create mode 100644 drivers/pci/host/pci-keystone.c
>>>   create mode 100644 drivers/pci/host/pci-keystone.h
>>>
>>> --
>>> 1.7.9.5
>>>
>
