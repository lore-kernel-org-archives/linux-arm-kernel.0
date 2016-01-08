From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 8 Jan 2016 11:37:09 +0530
Subject: dra7xx pci driver broken on dra7xx-evm
In-Reply-To: <20160107215946.GP12777@atomide.com>
References: <20160106214518.GA6106@localhost.localdomain>
 <568DF4FE.5010704@ti.com> <568ED7FA.4000508@ti.com>
 <20160107215946.GP12777@atomide.com>
Message-ID: <568F520D.9050807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 08 January 2016 03:29 AM, Tony Lindgren wrote:
> * Suman Anna <s-anna@ti.com> [160107 13:26]:
>> On 01/06/2016 11:17 PM, Kishon Vijay Abraham I wrote:
>>> Hi,
>>
>> + Tero, Tony and linux-omap
>>
>>>
>>> On Thursday 07 January 2016 03:15 AM, Richard Cochran wrote:
>>>>
>>>> The dra7xx-evm box freezes hard at the very first PCI bus access, the
>>>> call to in dra7xx_pcie_readl() in dra7xx_pcie_probe().
>>>>
>>>> The out-of-tree 3.14.53 TI driver performs a reset via platform data,
>>>> calling omap_device_assert_hardreset() by hook and crook.
>>
>> Yeah, this is the only feasible way and not break multi-arch atm until a
>> reset framework is in place. We have couple of drivers (omap_iommu and
>> wkup_m3_rproc) following this approach.
> 
> Sounds like doing reset with platform data is the way to go until the
> reset controller works.

All right. I'll post the patch to do reset using platform data.

Thanks
Kishon
