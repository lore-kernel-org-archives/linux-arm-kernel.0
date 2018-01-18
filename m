From: jeffy.chen@rock-chips.com (JeffyChen)
Date: Thu, 18 Jan 2018 22:11:41 +0800
Subject: [PATCH v4 05/13] iommu/rockchip: Use iopoll helpers to wait for
 hardware
In-Reply-To: <064794b9-98ae-221e-76bd-e11130514826@arm.com>
References: <20180118115251.5542-1-jeffy.chen@rock-chips.com>
 <20180118115251.5542-6-jeffy.chen@rock-chips.com>
 <064794b9-98ae-221e-76bd-e11130514826@arm.com>
Message-ID: <5A60AB1D.9080002@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On 01/18/2018 09:09 PM, Robin Murphy wrote:
>> -#define FORCE_RESET_TIMEOUT    100    /* ms */
>> +#define FORCE_RESET_TIMEOUT    100000    /* us */
>> +#define POLL_TIMEOUT        1000    /* us */
>
> Nit: the callsites look a bit odd with the combination of POLL_TIMEOUT
> and the magic number 100 - should we not also define something like
> POLL_PERIOD for that? Also POLL_TIMEOUT is a rather generic name and
> overlaps with several other drivers, so a namespace prefix would be
> helpful (i.e. RK_IOMMU_POLL*, or at least RK_POLL*).
>
> FWIW, my personal preference would be to also suffix these with _US for
> absolute clarity, but it's not essential (especially if longer names
> lead to more linebreaks at the callsites).
right, that make sense, will fix it in next version, thanks :)
>
> With those undocumented "100"s fixed up,
>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
