From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 24 Feb 2015 10:36:59 +0000
Subject: [PATCH v5 0/2] irqchip: Move Exynos PM to use stacked domains
In-Reply-To: <54EC4DF4.1010906@samsung.com>
References: <1424713534-7112-1-git-send-email-marc.zyngier@arm.com>
 <54EC4DF4.1010906@samsung.com>
Message-ID: <54EC544B.3030705@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pakaj,

On 24/02/15 10:09, Pankaj Dubey wrote:
> Hi Mark,
> 
> On Monday 23 February 2015 11:15 PM, Marc Zyngier wrote:
>> This series is extracted from [4], which is trying to remove all
>> traces of gic_arch_extn from the tree. As some maintainers are more
>> responsive than others (understatement of the year...), I've decided
>> to split it per sub-arch, and get it moving, at least partially.
>>
>> This series addresses Exynos by converting its PM support to a stacked
>> domain on top of the standard GIC.
>>
>> Based on 4.0-rc1.
>>
>> * From v4: [4]
>> - Extracted from the full series
>> - Rebased on 4.0-rc1
>>
>> * From v3 [3]:
>> - Rebased on top of the patch working around hardcoded IRQ on OMAP4/5 [4]
>> - Fixed more iMX6 DTs (Stephan)
>> - Fixed Exynos4/5 DTs
>>
>> * From v2 [2]:
>> - Addressed numerous comments from Thierry
>> - Merged bug fixes from Nishanth
>> - Merged bug fix from Stefan
>>
>> * From v1 [1]:
>> - Rebased on 3.19-rc3
>> - Fixed a number of additional platforms
>> - Added crossbar conversion to stacked domains
>> - Merged bug fixes from Nishanth
>>
>> [4]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/317531.html
>> [3]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315385.html
>> [2]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/314041.html
>> [1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/307338.html
>>
>> Marc Zyngier (2):
>>    ARM: exynos4/5: convert pmu wakeup to stacked domains
>>    DT: exynos: update PMU binding
>>
>>   .../devicetree/bindings/arm/samsung/pmu.txt        |  17 +++
>>   arch/arm/boot/dts/exynos4.dtsi                     |   4 +
>>   arch/arm/boot/dts/exynos5250.dtsi                  |   4 +
>>   arch/arm/boot/dts/exynos5420.dtsi                  |   4 +
>>   arch/arm/mach-exynos/exynos.c                      |  14 +--
>>   arch/arm/mach-exynos/suspend.c                     | 122 +++++++++++++++++++--
>>   6 files changed, 146 insertions(+), 19 deletions(-)
>>
> 
> I tested and verified S2R functionality on Exynos5250 based SMDK5250 
> board, and suspend-resume working fine. For testing on SMDK5250 you can 
> add my tested-by.
> 
> Tested-by: Pankaj Dubey <pankaj.dubey@samsung.com>

Thanks. Will you or Kukjin get that merged directly?

	M.
-- 
Jazz is not dead. It just smells funny...
