From: mikko.perttunen@kapsi.fi (Mikko Perttunen)
Date: Wed, 24 Sep 2014 21:34:16 +0300
Subject: [PATCH v5 3/4] ARM: tegra: Add thermal trip points for Jetson TK1
In-Reply-To: <20140924183204.GE27076@developer>
References: <1408616242-21009-1-git-send-email-mperttunen@nvidia.com>
 <1408616242-21009-4-git-send-email-mperttunen@nvidia.com>
 <20140924183204.GE27076@developer>
Message-ID: <54230EA8.7080604@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2014 09:32 PM, Eduardo Valentin wrote:
> Hello Mikko,
>
> On Thu, Aug 21, 2014 at 01:17:21PM +0300, Mikko Perttunen wrote:
>> This adds critical trip points to the Jetson TK1 device tree.
>> The device will do a controlled shutdown when either the CPU, GPU
>> or MEM thermal zone reaches 101 degrees Celsius.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> ---
>> v5: added cooling-maps nodes
>>
>
> OK. But no cooling map entry in it. What was the reason again you don't
> need/want to add the maps?

There is currently no cooling device to map to.

Mikko

>
>>   arch/arm/boot/dts/tegra124-jetson-tk1.dts | 41 +++++++++++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
>> index 0cdb5cf..bcdab7f 100644
>> --- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
>> +++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
>> @@ -1876,4 +1876,45 @@
>>   			 <&tegra_car TEGRA124_CLK_EXTERN1>;
>>   		clock-names = "pll_a", "pll_a_out0", "mclk";
>>   	};
>> +
>> +	thermal-zones {
>> +		cpu {
>> +			trips {
>> +				trip at 0 {
>> +					temperature = <101000>;
>> +					hysteresis = <0>;
>> +					type = "critical";
>> +				};
>> +			};
>> +
>> +			cooling-maps {
>> +			};
>> +		};
>> +
>> +		mem {
>> +			trips {
>> +				trip at 0 {
>> +					temperature = <101000>;
>> +					hysteresis = <0>;
>> +					type = "critical";
>> +				};
>> +			};
>> +
>> +			cooling-maps {
>> +			};
>> +		};
>> +
>> +		gpu {
>> +			trips {
>> +				trip at 0 {
>> +					temperature = <101000>;
>> +					hysteresis = <0>;
>> +					type = "critical";
>> +				};
>> +			};
>> +
>> +			cooling-maps {
>> +			};
>> +		};
>> +	};
>>   };
>> --
>> 1.8.1.5
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
