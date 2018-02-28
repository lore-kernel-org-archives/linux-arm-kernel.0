From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 28 Feb 2018 15:34:20 -0500
Subject: [PATCH 02/37] iommu/sva: Bind process address spaces to devices
In-Reply-To: <20180212183352.22730-3-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-3-jean-philippe.brucker@arm.com>
Message-ID: <bce32071-4159-3bdd-1e03-77f540ee4509@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/12/2018 1:33 PM, Jean-Philippe Brucker wrote:
> +int iommu_sva_unbind_group(struct iommu_group *group, int pasid)
> +{
> +	struct group_device *device;
> +
> +	mutex_lock(&group->mutex);
> +	list_for_each_entry(device, &group->devices, list)
> +		iommu_sva_unbind_device(device->dev, pasid);
> +	mutex_unlock(&group->mutex);
> +
> +	return 0;
> +}

I think we should handle the errors returned by iommu_sva_unbind_device() here
or at least print a warning if we want to still continue unbinding. 

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
