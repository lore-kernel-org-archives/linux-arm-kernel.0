From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 24 Sep 2017 20:30:23 -0400
Subject: [PATCH 3/5] PCI: make pci_flr_wait() generic and rename to
 pci_dev_wait()
In-Reply-To: <20170924130806.GA12285@infradead.org>
References: <1506212218-29103-1-git-send-email-okaya@codeaurora.org>
 <1506212218-29103-3-git-send-email-okaya@codeaurora.org>
 <20170924130806.GA12285@infradead.org>
Message-ID: <e14953c9-f49a-0728-6a22-b705d7551f03@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/24/2017 9:08 AM, Christoph Hellwig wrote:
> On Sat, Sep 23, 2017 at 08:16:56PM -0400, Sinan Kaya wrote:
>> Rev 3.1 Sec 2.3.1 Request Handling Rules:
>> Valid reset conditions after which a device is permitted to return CRS
>> are:
>> * Cold, Warm, and Hot Resets,
>> * FLR
>> * A reset initiated in response to a D3hot to D0 uninitialized
>>
>> Try to reuse FLR implementation towards other reset types.
> 
> Maybe call it pci_reset_wait instead of pci_dev_wait?
> 

I can go for pci_dev_reset_wait(). I was using the PCI directory function
naming nomenclature where some functions using struct pci_dev start with
pci_dev and others using struct pci_bus start with pci_bus.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
