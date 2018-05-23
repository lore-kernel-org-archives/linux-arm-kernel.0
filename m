From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 22 May 2018 22:40:16 -0400
Subject: [PATCH] PCI/portdrv: do not disable device on remove()
In-Reply-To: <20180523022431.GA15069@wunner.de>
References: <1527011883-21320-1-git-send-email-okaya@codeaurora.org>
 <20180523022431.GA15069@wunner.de>
Message-ID: <8c91a923-1a3a-55fb-e812-62dd69d99975@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/22/2018 10:24 PM, Lukas Wunner wrote:
> On Tue, May 22, 2018 at 01:58:00PM -0400, Sinan Kaya wrote:
>> --- a/drivers/pci/pcie/portdrv_core.c
>> +++ b/drivers/pci/pcie/portdrv_core.c
>> @@ -409,7 +409,6 @@ void pcie_port_device_remove(struct pci_dev *dev)
>>  {
>>  	device_for_each_child(&dev->dev, NULL, remove_iter);
>>  	pci_free_irq_vectors(dev);
>> -	pci_disable_device(dev);
>>  }
> 
> Shutdown aside, pci_disable_device() is also not called in the ->remove
> path with this patch, right?  Seems wrong.  E.g. when unbinding the driver
> from the root port device, or when unplugging a port (happens all the time
> with Thunderbolt).

Agreed. I'll spin another version where I skip disable on shutdown path only.

> 
> Thanks,
> 
> Lukas
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
