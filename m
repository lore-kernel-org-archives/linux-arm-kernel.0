From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 29 Mar 2016 15:46:00 +0200
Subject: [PATCH] ARM: at91/dt: sama5d2: add LCD controller
In-Reply-To: <56E17731.6020600@atmel.com>
References: <1457616316-12613-1-git-send-email-nicolas.ferre@atmel.com>
 <56E17731.6020600@atmel.com>
Message-ID: <56FA8718.7090903@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 10/03/2016 14:31, Nicolas Ferre a ?crit :
> Note to myself: change the $subject line to:
> ARM: dts: at91: sama5d2: add LCD controller
> 
> :-)

With $subject changed, queued in at91-4.7-dt branch.

> Le 10/03/2016 14:25, Nicolas Ferre a ?crit :
>> Add LCD controller node that binds to the atmel_hlcdc DRM driver.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>>  arch/arm/boot/dts/sama5d2.dtsi | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
>> index 78996bdbd3df..ce6df4d48bf9 100644
>> --- a/arch/arm/boot/dts/sama5d2.dtsi
>> +++ b/arch/arm/boot/dts/sama5d2.dtsi
>> @@ -319,6 +319,32 @@
>>  			#size-cells = <1>;
>>  			ranges;
>>  
>> +			hlcdc: hlcdc at f0000000 {
>> +				compatible = "atmel,sama5d2-hlcdc";
>> +				reg = <0xf0000000 0x2000>;
>> +				interrupts = <45 IRQ_TYPE_LEVEL_HIGH 0>;
>> +				clocks = <&lcdc_clk>, <&lcdck>, <&clk32k>;
>> +				clock-names = "periph_clk","sys_clk", "slow_clk";
>> +				status = "disabled";
>> +
>> +				hlcdc-display-controller {
>> +					compatible = "atmel,hlcdc-display-controller";
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +
>> +					port at 0 {
>> +						#address-cells = <1>;
>> +						#size-cells = <0>;
>> +						reg = <0>;
>> +					};
>> +				};
>> +
>> +				hlcdc_pwm: hlcdc-pwm {
>> +					compatible = "atmel,hlcdc-pwm";
>> +					#pwm-cells = <3>;
>> +				};
>> +			};
>> +
>>  			ramc0: ramc at f000c000 {
>>  				compatible = "atmel,sama5d3-ddramc";
>>  				reg = <0xf000c000 0x200>;
>>
> 
> 


-- 
Nicolas Ferre
