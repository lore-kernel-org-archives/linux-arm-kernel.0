From: jeffy.chen@rock-chips.com (JeffyChen)
Date: Thu, 25 Jan 2018 18:24:37 +0800
Subject: [PATCH v4 08/13] iommu/rockchip: Control clocks needed to access
 the IOMMU
In-Reply-To: <c05d4794-b76d-cfaa-d7ed-c44108117ee2@rock-chips.com>
References: <20180118115251.5542-1-jeffy.chen@rock-chips.com>
 <20180118115251.5542-9-jeffy.chen@rock-chips.com>
 <c188e6a9-744c-d984-545c-408607f35cc9@arm.com>
 <5A60AE41.2050101@rock-chips.com>
 <1f4b3c0d-1414-0012-a072-f4a11f432c21@rock-chips.com>
 <5A654925.9020203@rock-chips.com> <5A6563FA.8080602@rock-chips.com>
 <c05d4794-b76d-cfaa-d7ed-c44108117ee2@rock-chips.com>
Message-ID: <5A69B065.30501@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/2018 05:42 PM, Randy Li wrote:
>>>
>>
>> confirmed with Simon, there might be some iommus don't have a pd, and
> We use the pd to control the NIU node(not on upstream), without a pd or
> fake pd, none of the platform would work.
after talked offline, it's possible to have iommu without pd in upstream 
kernel(and chromeos kernel), but on our internal kernel, the drivers 
would require pd(or fake pd) to reset modules when error happens.

anyway, i think that means we do need clock control here.

>> the CONFIG_PM could be disabled.I am hard to believe a modern platform
>> can work without that.
>>
>> so it might be better to control clocks in iommu driver itself.
>I won't
> insist how the version of the iommu patch on the upstream, I
> just post an idea here.
> The version for kernel 4.4 is under internal review, the implementation
> has been modified many times.
>
> I would suggest the managing clocks in pd is a more easy way and don't
> need to spare those thing in two places.
