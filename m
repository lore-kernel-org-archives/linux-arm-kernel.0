From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 3 Dec 2017 14:29:03 -0500
Subject: [Intel-gfx] [PATCH V3 09/29] drm/i915: deprecate
 pci_get_bus_and_slot()
In-Reply-To: <9046d23e-412d-9d9f-147f-a3bc6eea34fc@codeaurora.org>
References: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
 <1511801886-6753-10-git-send-email-okaya@codeaurora.org>
 <20171128153051.GU10981@intel.com>
 <9046d23e-412d-9d9f-147f-a3bc6eea34fc@codeaurora.org>
Message-ID: <ad60832e-a0bd-007f-293f-dc5ad3e629d5@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/28/2017 11:29 AM, Sinan Kaya wrote:
> On 11/28/2017 10:30 AM, Ville Syrj?l? wrote:
>>> +	dev_priv->bridge_dev =
>>> +		pci_get_domain_bus_and_slot(domain, 0, PCI_DEVFN(0, 0));
>> Maybe just pci_get_slot(pdev->bus, PCI_DEVFN(0, 0)) ?
>>
>> I guess if we want to be pedantic we could go for:
>>
>> bus = pci_find_host_bridge(pdev->bus)->bus;
>> pci_get_slot(bus, PCI_DEVFN(0, 0))
>>
>> but I think the GPU should always be on the root bus, so the simpler
>> form should be fine.
>>
> 
> All three of these should be correct. 
> 
> I'll use pci_get_slot(pdev->bus, PCI_DEVFN(0, 0)) as you suggested.
> 

Now that I think about this more, I think my version is a simpler change
and does not introduce "new features" by assuming GPU and host to be
on the same bus similar to the original code. 

Original code could have used pci_get_slot() too. Since all of them are
correct, mine is slightly more correct; I'd like to keep mine.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
