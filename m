From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Tue, 13 Feb 2018 12:57:56 +0000
Subject: [PATCH 04/37] iommu/sva: Add a mm_exit callback for device drivers
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D1910028F9@SHSMSX101.ccr.corp.intel.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-5-jean-philippe.brucker@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D1910028F9@SHSMSX101.ccr.corp.intel.com>
Message-ID: <7c4e5d24-6560-44a8-2bdc-890cd06603b3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/02/18 08:11, Tian, Kevin wrote:
>> From: Jean-Philippe Brucker
>> Sent: Tuesday, February 13, 2018 2:33 AM
>>
>> When an mm exits, devices that were bound to it must stop performing
>> DMA
>> on its PASID. Let device drivers register a callback to be notified on mm
>> exit. Add the callback to the iommu_param structure attached to struct
>> device.
> 
> what about registering the callback in sva_device_init? 

I don't have a preference. This way it look like
iommu_register_device_fault_handler, but adding the callback to
sva_device_init makes sense too.

Thanks,
Jean
