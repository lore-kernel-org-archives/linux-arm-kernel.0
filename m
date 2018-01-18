From: jeffy.chen@rock-chips.com (JeffyChen)
Date: Thu, 18 Jan 2018 22:22:53 +0800
Subject: [PATCH v4 04/13] iommu/rockchip: Fix error handling in attach
In-Reply-To: <fa4277ef-ddfe-e23b-034c-167281cf0db1@arm.com>
References: <20180118115251.5542-1-jeffy.chen@rock-chips.com>
 <20180118115251.5542-5-jeffy.chen@rock-chips.com>
 <fa4277ef-ddfe-e23b-034c-167281cf0db1@arm.com>
Message-ID: <5A60ADBD.4050303@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On 01/18/2018 09:23 PM, Robin Murphy wrote:
>>
>> @@ -837,7 +837,7 @@ static int rk_iommu_attach_device(struct
>> iommu_domain *domain,
>>       ret = rk_iommu_enable_paging(iommu);
>>       if (ret)
>> -        return ret;
>> +        goto err_disable_stall;
>>       spin_lock_irqsave(&rk_domain->iommus_lock, flags);
>>       list_add_tail(&iommu->node, &rk_domain->iommus);
>> @@ -848,6 +848,11 @@ static int rk_iommu_attach_device(struct
>> iommu_domain *domain,
>>       rk_iommu_disable_stall(iommu);
>>       return 0;
>
> Nit: if you like, it looks reasonable to name the label
> "out_disable_stall" and remove these lines above here, to save the
> duplication between the error and success paths (since ret will already
> be 0 on the latter).
>
right, i think so, will do it in the next version.
> Either way,
>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
