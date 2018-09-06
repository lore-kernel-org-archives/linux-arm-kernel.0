From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Thu, 6 Sep 2018 13:45:36 +0100
Subject: [PATCH v2 01/40] iommu: Introduce Shared Virtual Addressing API
In-Reply-To: <ed39159c-087e-7e56-7d29-d1de9fa1677f@amd.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-2-jean-philippe.brucker@arm.com>
 <bf42affd-e9d0-e4fc-6d28-f3c3f7795348@redhat.com>
 <03d31ba5-1eda-ea86-8c0c-91d14c86fe83@arm.com>
 <ed39159c-087e-7e56-7d29-d1de9fa1677f@amd.com>
Message-ID: <f0b317d5-e2e9-5478-952c-05e8b97bd68b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/2018 12:12, Christian K?nig wrote:
> Am 06.09.2018 um 13:09 schrieb Jean-Philippe Brucker:
>> Hi Eric,
>>
>> Thanks for reviewing
>>
>> On 05/09/2018 12:29, Auger Eric wrote:
>>>> +int iommu_sva_device_init(struct device *dev, unsigned long features,
>>>> +????????????? unsigned int max_pasid)
>>> what about min_pasid?
>> No one asked for it... The max_pasid parameter is here for drivers that
>> have vendor-specific PASID size limits, such as AMD KFD (see
>> kfd_iommu_device_init and
>> https://patchwork.kernel.org/patch/9989307/#21389571). But in most cases
>> the PASID size will only depend on the PCI PASID capability and the
>> IOMMU limits, both known by the IOMMU driver, so device drivers won't
>> have to set max_pasid.
>>
>> IOMMU drivers need to set min_pasid in the sva_device_init callback
>> because it may be either 1 (e.g. Arm where PASID #0 is reserved) or 0
>> (Intel Vt-d rev2), but at the moment I can't see a reason for device
>> drivers to override min_pasid
> 
> Sorry to ruin your day, but if I'm not completely mistaken PASID zero is
> reserved in the AMD KFD as well.

Heh, fair enough. I'll add the min_pasid parameter

Thanks,
Jean
