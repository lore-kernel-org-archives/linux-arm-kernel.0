From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 24 Apr 2014 18:06:17 -0600
Subject: [PATCH 3/3] pci: add DT based ARM Versatile PCI host driver
In-Reply-To: <CAL_JsqLsDge54k5v_R9rvaGTrPu2qhC5shgg3dNAqV3re+ZPxQ@mail.gmail.com>
References: <1395960398-4238-1-git-send-email-robherring2@gmail.com>
 <1395960398-4238-4-git-send-email-robherring2@gmail.com>
 <20140424232431.GO29593@google.com>
 <CAL_JsqLsDge54k5v_R9rvaGTrPu2qhC5shgg3dNAqV3re+ZPxQ@mail.gmail.com>
Message-ID: <CAErSpo6GjhhForKPbH9A34DvV9HuOH1oqA2EBNpDFWiQPd0PXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 5:37 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Thu, Apr 24, 2014 at 6:24 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Thu, Mar 27, 2014 at 05:46:38PM -0500, Rob Herring wrote:
>>> From: Rob Herring <robh@kernel.org>
>>>
>>> This converts the Versatile PCI host code to a platform driver using
>>> of_create_pci_host_bridge for parsing DT and setup.
>>>
>>> I think more of this setup could be done by the core code. There are
>>> accesses to the host's config space (accesses using local_pci_cfg_base)
>>> which seem like they could be done by the core code or using standard
>>> config space accessors. The problem is bridge->bus->self is needed, but
>>> it does not get setup. I'm not exactly sure how that should work.
>>>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>> ...
>
>>> +     bridge = of_create_pci_host_bridge(&pdev->dev, &pci_versatile_ops, &sys);
>>
>> Are we still relying on the PCI core to default to a bus number range of
>> 00-ff?  Can we not do that?
>
> No, that comes from DT.

Oh, good.  That's done inside of_create_pci_host_bridge(), then?  (I
haven't looked at that code.)

Bjorn
