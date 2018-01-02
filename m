From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 2 Jan 2018 10:47:56 -0500
Subject: [PATCH V2 3/7] PCI: make pci_flr_wait() generic and rename to
 pci_dev_wait()
In-Reply-To: <20171213224304.GK30595@bhelgaas-glaptop.roam.corp.google.com>
References: <1511763628-11856-1-git-send-email-okaya@codeaurora.org>
 <1511763628-11856-4-git-send-email-okaya@codeaurora.org>
 <20171213224304.GK30595@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <b3a575d2-b4dd-2d49-f78d-a76d88dfcd6e@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13/2017 5:43 PM, Bjorn Helgaas wrote:
>> +
>> +	/*
>> +	 * Per PCIe r3.1, sec 6.6.2, a device must complete an FLR within
> I think this should reference the "Advanced Capabilities for
> Conventional PCI" ECN, shouldn't it?  The one I see is dated 13 April
> 2006, updated 27 July 2006, and I don't see a PCI spec that includes
> it.

I'll add reference to PCI spec as well. Any other comments on the series?

> 
>> +	 * 100ms, but may silently discard requests while the FLR is in
>> +	 * progress.  Wait 100ms before trying to access the device.
>> +	 */
>> +	msleep(100);
>> +
>> +	return pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
> CRS is not applicable to conventional PCI.  The ECN mentions waiting
> 100ms.  I don't see anything about polling after that, but I guess it
> probably doesn't hurt anything.

ok, I'll keep it as it is.

> 
>>  }


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
