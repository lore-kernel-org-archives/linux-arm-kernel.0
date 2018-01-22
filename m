From: randy.li@rock-chips.com (Randy Li)
Date: Mon, 22 Jan 2018 09:18:09 +0800
Subject: [PATCH v4 08/13] iommu/rockchip: Control clocks needed to access
 the IOMMU
In-Reply-To: <5A60AE41.2050101@rock-chips.com>
References: <20180118115251.5542-1-jeffy.chen@rock-chips.com>
 <20180118115251.5542-9-jeffy.chen@rock-chips.com>
 <c188e6a9-744c-d984-545c-408607f35cc9@arm.com>
 <5A60AE41.2050101@rock-chips.com>
Message-ID: <1f4b3c0d-1414-0012-a072-f4a11f432c21@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/18/2018 10:25 PM, JeffyChen wrote:
> Hi Robin,
> 
> On 01/18/2018 08:27 PM, Robin Murphy wrote:
>>>
>>
>> Is it worth using the clk_bulk_*() APIs for this? At a glance, most of
>> the code being added here appears to duplicate what those functions
>> already do (but I'm no clk API expert, for sure).
> right, i think it's doable, the clk_bulk APIs are very helpful. i think 
> we didn't use that is because this patch were wrote for the chromeos 4.4 
> kernel, which doesn't have clk_bulk yet:)
> 
> will do it in the next version, thanks.
Also the power domain driver could manage the clocks as well, I would 
suggest to use pm_runtime_*.
>>
>> Robin.
> 
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 

-- 
Randy Li
