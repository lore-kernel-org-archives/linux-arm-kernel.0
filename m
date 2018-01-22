From: jeffy.chen@rock-chips.com (JeffyChen)
Date: Mon, 22 Jan 2018 10:15:01 +0800
Subject: [PATCH v4 08/13] iommu/rockchip: Control clocks needed to access
 the IOMMU
In-Reply-To: <1f4b3c0d-1414-0012-a072-f4a11f432c21@rock-chips.com>
References: <20180118115251.5542-1-jeffy.chen@rock-chips.com>
 <20180118115251.5542-9-jeffy.chen@rock-chips.com>
 <c188e6a9-744c-d984-545c-408607f35cc9@arm.com>
 <5A60AE41.2050101@rock-chips.com>
 <1f4b3c0d-1414-0012-a072-f4a11f432c21@rock-chips.com>
Message-ID: <5A654925.9020203@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Randy,

On 01/22/2018 09:18 AM, Randy Li wrote:
>>
> Also the power domain driver could manage the clocks as well, I would
> suggest to use pm_runtime_*.

actually the clocks required by pm domain may not be the same as what we 
want to control here, there might be some clocks only be needed when 
accessing mmu registers.

but i'm not very sure about that, will confirm it with Simon Xue.
