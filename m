From: jeffy.chen@rock-chips.com (JeffyChen)
Date: Fri, 12 Jan 2018 08:33:17 +0800
Subject: [PATCH 2/9] iommu/rockchip: Fix error handling in attach
In-Reply-To: <427ecf29-2024-b746-c567-903c1ce02e75@arm.com>
References: <20180111082229.24011-1-jeffy.chen@rock-chips.com>
 <20180111082229.24011-3-jeffy.chen@rock-chips.com>
 <427ecf29-2024-b746-c567-903c1ce02e75@arm.com>
Message-ID: <5A58024D.2010402@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

thanks for your reply.

On 01/11/2018 11:47 PM, Robin Murphy wrote:
>>
>> +    for (i = 0; i < iommu->num_irq; i++) {
>> +        ret = devm_request_irq(iommu->dev, iommu->irq[i], rk_iommu_irq,
>> +                       IRQF_SHARED, dev_name(dev), iommu);
>
> Why aren't we simply requesting the IRQ once in rk_iommu_probe()? Given
> that the hardware doesn't handle multiple translation contexts, there
> doesn't seem to be much point in being this dynamic about it.
>
it make sense, will do it in next version:)
> Robin.
