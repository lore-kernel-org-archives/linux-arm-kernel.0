From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Fri, 2 Mar 2018 12:32:22 +0000
Subject: [PATCH 02/37] iommu/sva: Bind process address spaces to devices
In-Reply-To: <bce32071-4159-3bdd-1e03-77f540ee4509@codeaurora.org>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-3-jean-philippe.brucker@arm.com>
 <bce32071-4159-3bdd-1e03-77f540ee4509@codeaurora.org>
Message-ID: <78212417-ae79-0fb2-1233-d1604412bfec@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/02/18 20:34, Sinan Kaya wrote:
> On 2/12/2018 1:33 PM, Jean-Philippe Brucker wrote:
>> +int iommu_sva_unbind_group(struct iommu_group *group, int pasid)
>> +{
>> +	struct group_device *device;
>> +
>> +	mutex_lock(&group->mutex);
>> +	list_for_each_entry(device, &group->devices, list)
>> +		iommu_sva_unbind_device(device->dev, pasid);
>> +	mutex_unlock(&group->mutex);
>> +
>> +	return 0;
>> +}
> 
> I think we should handle the errors returned by iommu_sva_unbind_device() here
> or at least print a warning if we want to still continue unbinding. 

Agreed, though bind_group/unbind_group are probably going away in next
series

Thanks,
Jean
