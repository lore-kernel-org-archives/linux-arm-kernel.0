From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Wed, 21 Jun 2017 09:50:56 +0200
Subject: [PATCH v5 1/4] ARM: dts: at91: sama5d2_xplained: enable ADTRG pin
In-Reply-To: <20170620175552.2ec49c56@kernel.org>
References: <1497533097-12052-1-git-send-email-eugen.hristev@microchip.com>
 <1497533097-12052-2-git-send-email-eugen.hristev@microchip.com>
 <20170620175552.2ec49c56@kernel.org>
Message-ID: <09e9462b-f375-2259-179f-0a723b2cb5aa@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/06/2017 at 18:55, Jonathan Cameron wrote:
> On Thu, 15 Jun 2017 16:24:54 +0300
> Eugen Hristev <eugen.hristev@microchip.com> wrote:
> 
>> Enable pinctrl for ADTRG pin (PD31) for ADC hardware trigger support.
>>
>> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
>> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> The driver changes are on their way upstream.
> 
> Acked-by: Jonathan Cameron <jic23@kernel.org>

Thanks Jonathan,

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Eugen, note that we may need to wait for 4.14 as our changes for 4.13
are already queued in arm-soc...

Best regards,

>> ---
>>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
>> index 0bef9e0..04754b1 100644
>> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
>> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
>> @@ -303,7 +303,7 @@
>>  				vddana-supply = <&vdd_3v3_lp_reg>;
>>  				vref-supply = <&vdd_3v3_lp_reg>;
>>  				pinctrl-names = "default";
>> -				pinctrl-0 = <&pinctrl_adc_default>;
>> +				pinctrl-0 = <&pinctrl_adc_default &pinctrl_adtrg_default>;
>>  				status = "okay";
>>  			};
>>  
>> @@ -322,6 +322,20 @@
>>  					bias-disable;
>>  				};
>>  
>> +				/*
>> +				 * The ADTRG pin can work on any edge type.
>> +				 * In here it's being pulled up, so need to
>> +				 * connect it to ground to get an edge e.g.
>> +				 * Trigger can be configured on falling, rise
>> +				 * or any edge, and the pull-up can be changed
>> +				 * to pull-down or left floating according to
>> +				 * needs.
>> +				 */
>> +				pinctrl_adtrg_default: adtrg_default {
>> +					pinmux = <PIN_PD31__ADTRG>;
>> +					bias-pull-up;
>> +				};
>> +
>>  				pinctrl_charger_chglev: charger_chglev {
>>  					pinmux = <PIN_PA12__GPIO>;
>>  					bias-disable;
> 
> 


-- 
Nicolas Ferre
