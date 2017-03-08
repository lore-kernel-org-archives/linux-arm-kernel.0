From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 8 Mar 2017 12:15:53 +0000
Subject: [PATCH 09/11] arm64: tegra: Add GPIO keys on P2771
In-Reply-To: <6e9043ac-0e3c-6b17-fd76-5792820d55b1@nvidia.com>
References: <20170223173053.19701-1-thierry.reding@gmail.com>
 <20170223173053.19701-9-thierry.reding@gmail.com>
 <6e9043ac-0e3c-6b17-fd76-5792820d55b1@nvidia.com>
Message-ID: <ae214cf3-df2d-1036-b702-c8436471bfe8@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 08/03/17 12:03, Jon Hunter wrote:
> 
> 
> On 23/02/17 17:30, Thierry Reding wrote:
>> From: Thierry Reding <treding@nvidia.com>
>>
>> The P2771 has three keys (power, volume up and volume down) that are
>> connected to pins on the AON GPIO controller.
>>
>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>> ---
>>  arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts | 34 ++++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
>> index 0d3c0996d832..1c195d71806d 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
>> +++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
>> @@ -1,8 +1,42 @@
>>  /dts-v1/;
>>  
>> +#include <dt-bindings/input/linux-event-codes.h>
>> +
>>  #include "tegra186-p3310.dtsi"
>>  
>>  / {
>>  	model = "NVIDIA Tegra186 P2771-0000 Development Board";
>>  	compatible = "nvidia,p2771-0000", "nvidia,tegra186";
>> +
>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +
>> +		power {
>> +			label = "Power";
>> +			gpios = <&gpio_aon TEGRA_AON_GPIO(FF, 0)
>> +					   GPIO_ACTIVE_LOW>;
>> +			linux,input-type = <EV_KEY>;
>> +			linux,code = <KEY_POWER>;
>> +			debounce-interval = <10>;
>> +			wakeup-source;
>> +		};
>> +
>> +		volume-up {
>> +			label = "Volume Up";
>> +			gpios = <&gpio_aon TEGRA_AON_GPIO(FF, 1)
>> +					   GPIO_ACTIVE_LOW>;
>> +			linux,input-type = <EV_KEY>;
>> +			linux,code = <KEY_VOLUMEUP>;
>> +			debounce-interval = <10>;
>> +		};
> 
> My schematic shows this pin as 'force-recovery'.
> 
>> +
>> +		volume-down {
>> +			label = "Volume Down";
>> +			gpios = <&gpio_aon TEGRA_AON_GPIO(FF, 2)
>> +					   GPIO_ACTIVE_LOW>;
>> +			linux,input-type = <EV_KEY>;
>> +			linux,code = <KEY_VOLUMEDOWN>;
>> +			debounce-interval = <10>;
>> +		};
>> +	};
>>  };
> 
> And this one as 'sleep_l'.

Actually, I do see this as "VOL Down". So ignore that and I assume we
re-use recovery so ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
