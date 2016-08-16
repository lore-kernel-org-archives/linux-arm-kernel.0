From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 16 Aug 2016 17:08:14 +0900
Subject: [PATCH 2/7] Documentation: bindings: Add Exynos5433 PMU compatible
In-Reply-To: <488f925b-4c37-1759-04a8-11d992405527@samsung.com>
References: <1471328843-26653-1-git-send-email-cw00.choi@samsung.com>
 <1471328843-26653-3-git-send-email-cw00.choi@samsung.com>
 <CGME20160816074111epcas1p2ef832dad29a5b0a81fc5e783aed70ee4@epcas1p2.samsung.com>
 <488f925b-4c37-1759-04a8-11d992405527@samsung.com>
Message-ID: <57B2C9EE.6000005@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 2016? 08? 16? 16:40, Krzysztof Kozlowski wrote:
> On 08/16/2016 08:27 AM, Chanwoo Choi wrote:
>> This patch adds the exynos5433 PMU compatible to support the access
>> of PMU (Power Management Unit) block.
>>
>> Cc: Kukjin Kim <kgene@kernel.org>
>> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  Documentation/devicetree/bindings/arm/samsung/pmu.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
>> index 2d6356d8daf4..bf5fc59a6938 100644
>> --- a/Documentation/devicetree/bindings/arm/samsung/pmu.txt
>> +++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
>> @@ -10,6 +10,7 @@ Properties:
>>  		   - "samsung,exynos5260-pmu" - for Exynos5260 SoC.
>>  		   - "samsung,exynos5410-pmu" - for Exynos5410 SoC,
>>  		   - "samsung,exynos5420-pmu" - for Exynos5420 SoC.
>> +		   - "samsung,exynos5433-pmu" - for Exynos5433 SoC.
>>  		   - "samsung,exynos7-pmu" - for Exynos7 SoC.
>>  		second value must be always "syscon".
> 
> Is there any plan to add Exynos5433 support to
> drivers/soc/samsung/exynos-pmu.c? If no... then exynos7-pmu might be
> reused. If yes, then this makes sense.

Yes.
I'll support the suspend-to-ram for Exynos5433. But it is not right now.
because the current kernel support the suspend-to-ram for only 32-bit Exynos.
and the pm/suspend code are included in in arch/arm/mach-exynos/.

To support the suspend-to-ram for 64bit Exynos, I need a lot of time
to support the 64-bit suspend.

Regards,
Chanwoo Choi
