From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 15 Dec 2017 23:06:51 +0800
Subject: [PATCH v3] ARM64: dts: meson-axg: enable IR controller
In-Reply-To: <1513350088.2261.62.camel@baylibre.com>
References: <20171215145906.1494-1-yixun.lan@amlogic.com>
 <1513350088.2261.62.camel@baylibre.com>
Message-ID: <144d12a5-f5d4-dfe0-ea28-83362c58afdd@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jerome


On 12/15/2017 11:01 PM, Jerome Brunet wrote:
> On Fri, 2017-12-15 at 22:59 +0800, Yixun Lan wrote:
>> Enable IR remote controller which found in Amlogic's Meson-AXG SoCs.
>>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>>
>> ---
>>
>> Changes since v2 at [2]
>>  - rebase to Kevin's v4.16/dt64 branch
>>  - this patch depend on pinctrl DT driver
>>
>> Changes since v1 at [1]:
>>  - drop the compatbile 'amlogic,meson-gx-ir'
>>
>> [2]
>> http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005574.html
>>
>> [1]
>>  http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005527.html
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-axg-s400.dts |  6 ++++++
>>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi     | 14 ++++++++++++++
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
>> index 70eca1f8736a..e85fb665f12e 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
>> @@ -20,3 +20,9 @@
>>  &uart_AO {
>>  	status = "okay";
>>  };
>> +
>> +&ir {
>> +	status = "okay";
>> +	pinctrl-0 = <&remote_input_ao_pins>;
>> +	pinctrl-names = "default";
>> +};
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> index a0d7b10da512..1cd34141a5c1 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> @@ -223,6 +223,13 @@
>>  					#gpio-cells = <2>;
>>  					gpio-ranges = <&pinctrl_aobus 0 0 15>;
>>  				};
>> +
>> +				remote_input_ao_pins: remote_input_ao {
>> +					mux {
>> +						groups = "remote_input_ao";
>> +						function = "remote_input_ao";
>> +					};
>> +				};
>>  			};
>>  
>>  			uart_AO: serial at 3000 {
>> @@ -242,6 +249,13 @@
>>  				clock-names = "xtal", "pclk", "baud";
>>  				status = "disabled";
>>  			};
>> +
>> +			ir: ir at 8000 {
>> +				compatible = "amlogic,meson-gxbb-ir";
> 
> compatible = "amlogic,meson-axg-ir", "amlogic,meson-gxbb-ir";
> 
> please (and the binding doc patch)

what's the policy for adding new compatible string?

is this a must even we don't use it for now?
or what's the problem if adding it when we really need it

> 
>> +				reg = <0x0 0x8000 0x0 0x20>;
>> +				interrupts = <GIC_SPI 196 IRQ_TYPE_EDGE_RISING>;
>> +				status = "disabled";
>> +			};
>>  		};
>>  	};
>>  };
> 
> .
> 
