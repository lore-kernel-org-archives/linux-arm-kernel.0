From: Claudiu.Beznea@microchip.com (m18063)
Date: Thu, 23 Feb 2017 10:43:55 +0200
Subject: [PATCH] ATM: dts: at91: sama5d2_xplained: add pwm controller
In-Reply-To: <20170223084241.6eqm5jxe4t7fpn6a@piout.net>
References: <1487838778-13473-1-git-send-email-claudiu.beznea@microchip.com>
 <20170223084241.6eqm5jxe4t7fpn6a@piout.net>
Message-ID: <056978cb-f4af-aa0e-5c64-32b0bceddcf0@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I will correct it asap.

Thank you,
Claudiu Beznea

On 23.02.2017 10:42, Alexandre Belloni wrote:
> Hi,
>
> There is a typo in your subject, please fix.
>
> On 23/02/2017 at 10:32:58 +0200, Claudiu Beznea wrote:
>> Add pwm controller bindings for sam5d2_xplained
>> and enable it.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>>  arch/arm/boot/dts/at91-sama5d2_xplained_common.dtsi | 4 ++++
>>  arch/arm/boot/dts/sama5d2.dtsi                      | 8 ++++++++
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained_common.dtsi b/arch/arm/boot/dts/at91-sama5d2_xplained_common.dtsi
>> index 9fc270f..493ea29 100644
>> --- a/arch/arm/boot/dts/at91-sama5d2_xplained_common.dtsi
>> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained_common.dtsi
>> @@ -318,6 +318,10 @@
>>  				};
>>  			};
>>  
>> +			pwm0: pwm at f802c000 {
>> +				status = "okay";
>> +			};
>> +
>>  			flx0: flexcom at f8034000 {
>>  				atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_USART>;
>>  				status = "disabled"; /* conflict with ISC_D2 & ISC_D3 data pins */
>> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
>> index cd459e8..e88785e 100644
>> --- a/arch/arm/boot/dts/sama5d2.dtsi
>> +++ b/arch/arm/boot/dts/sama5d2.dtsi
>> @@ -1098,6 +1098,14 @@
>>  				status = "disabled";
>>  			};
>>  
>> +			pwm0: pwm at f802c000 {
>> +				compatible = "atmel,sama5d2-pwm";
> This compatible is not documented and is not used in any driver. Is that
> really working?
>
>> +				reg = <0xf802c000 0x4000>;
>> +				interrupts = <38 IRQ_TYPE_LEVEL_HIGH 7>;
>> +				#pwm-cells = <3>;
>> +				clocks = <&pwm_clk>;
>> +			};
>> +
>>  			sfr: sfr at f8030000 {
>>  				compatible = "atmel,sama5d2-sfr", "syscon";
>>  				reg = <0xf8030000 0x98>;
>> -- 
>> 2.7.4
>>
