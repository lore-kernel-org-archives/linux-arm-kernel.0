From: jianxin.pan@amlogic.com (Jianxin Pan)
Date: Thu, 20 Sep 2018 16:54:10 +0800
Subject: [PATCH v4 2/2] arm64: dts: meson-g12a: add initial g12a s905d2
 SoC DT support
In-Reply-To: <c16ae8cf-5802-778b-1fd8-494dfb2d8d1b@baylibre.com>
References: <1537427368-11104-1-git-send-email-jianxin.pan@amlogic.com>
 <1537427368-11104-3-git-send-email-jianxin.pan@amlogic.com>
 <c16ae8cf-5802-778b-1fd8-494dfb2d8d1b@baylibre.com>
Message-ID: <282176bb-2780-b8f4-5619-4edb24d37469@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/20/2018 3:54 PM, Neil Armstrong wrote:
> On 20/09/2018 09:09, Jianxin Pan wrote:
>> Try to add basic DT support for the Amlogic's Meson-G12A S905D2 SoC,
>> which describe components as follows: Reserve Memory, CPU, GIC, IRQ,
>> Timer, UART. It's capable of booting up into the serial console.
>>
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/Makefile            |   1 +
>>  arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts |  22 +++
>>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi     | 172 ++++++++++++++++++++++++
[...]
>> +#include "meson-g12a.dtsi"
>> +
>> +/ {
>> +	compatible = "amlogic,u200", "amlogic,g12a";
>> +	model = "Amlogic Meson G12A U200 Development Board";
>> +
>> +	aliases {
>> +		serial0 = &uart_AO;
>> +	};
> 
> Hi Jianxin,
> 
> Please add the /memory and /chosen nodes.
> 
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory at 0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x40000000>;
> +	};
> 
> Thanks,
> Neil
> 
> 
Hi Neil
Thanks for the review! I will add them.
>> +};
>> +
>> +&uart_AO {
>> +	status = "okay";
>> +};
>> +
> [...]
> 
> .
> 
