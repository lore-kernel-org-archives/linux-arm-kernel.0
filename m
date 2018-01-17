From: jeffy.chen@rock-chips.com (JeffyChen)
Date: Wed, 17 Jan 2018 20:53:32 +0800
Subject: [PATCH v2 09/13] iommu/rockchip: Use iommu_group_get_for_dev()
 for add_device
In-Reply-To: <5A5F45DA.5000104@rock-chips.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
 <20180116132540.18939-10-jeffy.chen@rock-chips.com>
 <4c1b2469-9a32-c6ca-522f-73143b0fa618@arm.com>
 <5A5F45DA.5000104@rock-chips.com>
Message-ID: <5A5F474C.8020606@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2018 08:47 PM, JeffyChen wrote:
>>>
>>> +static struct iommu_group *rk_iommu_device_group(struct device *dev)
>>> +{
>>> +    struct iommu_group *group;
>>> +    int ret;
>>> +
>>> +    group = iommu_group_get(dev);
>>> +    if (!group) {
>>
>> This check is pointless - if dev->iommu_group were non-NULL you wouldn't
>> have been called in the first place.
> right, it's allocated in the probe.
oops, sorry, i see, this is not needed because device_group() is only be 
called when iommu_group_get() returns NULL
