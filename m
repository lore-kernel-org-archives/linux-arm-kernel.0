From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 14 Apr 2016 14:48:22 +0900
Subject: [PATCH 3/7] ARM: dts: Add NoC Probe dt node for Exynos542x SoC
In-Reply-To: <570CAE67.4020001@samsung.com>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
 <1460091646-28701-4-git-send-email-cw00.choi@samsung.com>
 <570CAE67.4020001@samsung.com>
Message-ID: <570F2F26.9030408@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016? 04? 12? 17:14, Krzysztof Kozlowski wrote:
> On 04/08/2016 07:00 AM, Chanwoo Choi wrote:
>> This patch adds the NoCP (Network on Chip Probe) Device Tree node
>> to measure the bandwidth of memory and g3d in Exynos542x SoC.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos5420.dtsi | 36 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
>> index 7b99cb58d82d..d80f3b66f017 100644
>> --- a/arch/arm/boot/dts/exynos5420.dtsi
>> +++ b/arch/arm/boot/dts/exynos5420.dtsi
>> @@ -294,6 +294,42 @@
>>  		};
>>  	};
>>  
>> +	nocp_mem0_0: nocp_mem0_0 at 10CA1000 {
> 
> The node name should describe general class of device, so:
> 
> 	nocp_mem0_0: nocp at 10CA1000 {
> 		...
> 	}
> ?

I'll modify it.

> 
>> +		compatible = "samsung,exynos5420-nocp";
>> +		reg = <0x10CA1000 0x200>;
>> +		status = "disabled";
>> +	};
>> +
>> +	nocp_mem0_1: nocp_mem0_1 at 10CA1400 {
>> +		compatible = "samsung,exynos5420-nocp";
>> +		reg = <0x10CA1400 0x200>;
>> +		status = "disabled";
>> +	};
>> +
>> +	nocp_mem0_2: nocp_mem0_2 at 10CA1800 {
> 
> Shouldn't it be nocp_mem1_0?

I was mistaken. I'll fix it.

> 
>> +		compatible = "samsung,exynos5420-nocp";
>> +		reg = <0x10CA1800 0x200>;
>> +		status = "disabled";
>> +	};
>> +
>> +	nocp_mem0_3: nocp_mem0_3 at 10CA1C00 {
> 
> Shouldn't it be nocp_mem1_1?

ditto.

Best Regards,
Chanwoo Choi
