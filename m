From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 11 Dec 2015 00:25:37 -0300
Subject: [PATCH v5 3/7] ARM: dts: Exynos542x/5800: add CPU OPP properties
In-Reply-To: <20151211031646.GL3612@ubuntu>
References: <1449766729-435-1-git-send-email-b.zolnierkie@samsung.com>
 <1449766729-435-4-git-send-email-b.zolnierkie@samsung.com>
 <20151211031646.GL3612@ubuntu>
Message-ID: <566A4231.9050608@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Viresh,

On 12/11/2015 12:16 AM, Viresh Kumar wrote:
> On 10-12-15, 17:58, Bartlomiej Zolnierkiewicz wrote:
>> diff --git a/arch/arm/boot/dts/exynos5422-cpus.dtsi b/arch/arm/boot/dts/exynos5422-cpus.dtsi
>> index b7f60c8..9a5131d 100644
>> --- a/arch/arm/boot/dts/exynos5422-cpus.dtsi
>> +++ b/arch/arm/boot/dts/exynos5422-cpus.dtsi
>> @@ -20,8 +20,10 @@
>>  	device_type = "cpu";
>>  	compatible = "arm,cortex-a7";
>>  	reg = <0x100>;
>> +	clocks = <&clock CLK_KFC_CLK>;
>>  	clock-frequency = <1000000000>;
>>  	cci-control-port = <&cci_control0>;
>> +	operating-points-v2 = <&cpu1_opp_table>;
>>  };
> 
> Why do you need to update this file? This file is included by
> exynos5422-odroidxu3-common.dtsi, which already inherits cpus nodes
> from exynos5800.dtsi (which inherits exynos5420.dtsi).
> 
> i.e. operating-points-v2 should already be set.
>

The problem is that the big and LITTLE cores have different ordering per SoCs:

- Exynos5420 and Exynos5800: cpu0-3 (Cortex-A15) and cpu4-7 (Coretx-A7)
- Exynos5422: cpu0-3 (Cortex-A7) and cpu4-7 (Cortex-A15)

So the OPP tables are set in this DTSI file, to prevent the OPP tables
in the Exynos5422 to be inverted for the cluster 0 and 1.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
