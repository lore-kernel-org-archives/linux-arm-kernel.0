From: jeffy.chen@rock-chips.com (JeffyChen)
Date: Wed, 17 Jan 2018 15:47:47 +0800
Subject: [PATCH v2 11/13] iommu/rockchip: Use OF_IOMMU to attach devices
 automatically
In-Reply-To: <CAAFQd5AOZ797dNEvr5TbuWK-rw=dTCArUZM53t4_gNRugBd=sg@mail.gmail.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
 <20180116132540.18939-12-jeffy.chen@rock-chips.com>
 <CAAFQd5C=SM21CmL8J334HseJ6SJH1wAVzKhrsk_cXMmpf8mK8g@mail.gmail.com>
 <5A5EF94E.7010806@rock-chips.com>
 <CAAFQd5AOZ797dNEvr5TbuWK-rw=dTCArUZM53t4_gNRugBd=sg@mail.gmail.com>
Message-ID: <5A5EFFA3.6070206@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2018 03:30 PM, Tomasz Figa wrote:
>> >but it's possible the probe failed after calling iommu_device_set_fwnode, so
>> >i'll try to add some checks here, and maybe adjust probe() to prevent it
>> >too.
> I think iommu_device_set_fwnode() is not enough for of_iommu_xlate()
> to find the IOMMU. The IOMMU is actually added to the IOMMU list by
> iommu_device_register(), which is last in the sequence, so I guess we
> should be fine.
>
hmmm, the later patch would change that ;) i'll fix it in the next version.

> Best regards,
> Tomasz
>
>
>
