From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 14 Mar 2016 16:13:22 +0900
Subject: [PATCH 07/10] ARM: dts: Add thermal zone and cpufreq node for
 exynos3250-artik5 module
In-Reply-To: <56E662F6.4070200@samsung.com>
References: <1457921056-21257-1-git-send-email-cw00.choi@samsung.com>
 <1457921056-21257-9-git-send-email-cw00.choi@samsung.com>
 <56E662F6.4070200@samsung.com>
Message-ID: <56E66492.4070003@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016? 03? 14? 16:06, Krzysztof Kozlowski wrote:
> On 14.03.2016 11:04, Chanwoo Choi wrote:
>> This patch enables the CPU frequency scaling for exynos3250-artik5 module
>> and adds the thernal zones with cpu cooling device to prevent the overheat
>> temperature.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos3250-artik5.dtsi | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
> 
> The patch looks good but just squash it with 5/10 unless there is some
> benefit by splitting the features for many patches. The benefit would be
> for example submitting the work partially, in steps, following principle
> release-early-release-often... but this is not the case. You have
> everything ready and tested.

OK. I'll merge this patch with 5/10 patch.

Best Regards,
Chanwoo Choi

> 
> BR,
> Krzysztof
> 
>>
>> diff --git a/arch/arm/boot/dts/exynos3250-artik5.dtsi b/arch/arm/boot/dts/exynos3250-artik5.dtsi
>> index 75b291c10cdc..877e4827df83 100644
>> --- a/arch/arm/boot/dts/exynos3250-artik5.dtsi
>> +++ b/arch/arm/boot/dts/exynos3250-artik5.dtsi
>> @@ -31,6 +31,25 @@
>>  		compatible = "samsung,secure-firmware";
>>  		reg = <0x0205F000 0x1000>;
>>  	};
>> +
>> +	thermal-zones {
>> +		cpu_thermal: cpu-thermal {
>> +			cooling-maps {
>> +				map0 {
>> +					/* Corresponds to 500MHz */
>> +					cooling-device = <&cpu0 5 5>;
>> +				};
>> +				map1 {
>> +					/* Corresponds to 200MHz */
>> +					cooling-device = <&cpu0 8 8>;
>> +				};
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&cpu0 {
>> +	cpu0-supply = <&buck2_reg>;
>>  };
>>  
>>  &i2c_0 {
>> @@ -296,6 +315,10 @@
>>  	status = "okay";
>>  };
>>  
>> +&tmu {
>> +	status = "okay";
>> +};
>> +
>>  &xusbxti {
>>  	clock-frequency = <24000000>;
>>  };
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
