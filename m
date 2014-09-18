From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 18 Sep 2014 17:32:18 +0200
Subject: [PATCH v2 2/3] ARM: at91/dt: at91: use new pinctrl id for sama5
In-Reply-To: <540D63DA.5090207@atmel.com>
References: <1408849926-9603-1-git-send-email-mark.roszko@gmail.com>
 <1408849926-9603-2-git-send-email-mark.roszko@gmail.com>
 <540D63DA.5090207@atmel.com>
Message-ID: <541AFB02.2010900@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/2014 10:07, Nicolas Ferre :
> On 24/08/2014 05:12, Marek Roszko :
>> This switches the SAMA5D3 to use the new atmel,sama5d3-pinctrl id that was
>> added with the drive strength options patch.
>>
>> Signed-off-by: Marek Roszko <mark.roszko@gmail.com>
>> ---
>>  arch/arm/boot/dts/sama5d3.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
>> index 45013b8..7db0e85 100644
>> --- a/arch/arm/boot/dts/sama5d3.dtsi
>> +++ b/arch/arm/boot/dts/sama5d3.dtsi
>> @@ -428,7 +428,7 @@
>>  			pinctrl at fffff200 {
>>  				#address-cells = <1>;
>>  				#size-cells = <1>;
>> -				compatible = "atmel,at91sam9x5-pinctrl", "atmel,at91rm9200-pinctrl", "simple-bus";
>> +				compatible = "atmel,sama5d3-pinctrl", "atmel,at91rm9200-pinctrl", "simple-bus";
> 
> I'd better keep the compatibility with at91sam9x5, like it
> was before your patch: that will remove the dependency on
> the pinctrl series: what about:
> 
> +				compatible = "atmel,sama5d3-pinctrl", "atmel,at91sam9x5-pinctrl", "simple-bus";

So, with the modification that I did above:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

I also stack it to my at91-3.18-dt3 that will soon reach arm-soc (there
is no dependency with the other patches of the series anymore).

Linus, are the other two of the series ready to land in Mainline for
next kernel release (3.18)? (I'm just asking because you said you would
do a "tentative").

Thanks, bye,

> 
>>  				ranges = <0xfffff200 0xfffff200 0xa00>;
>>  				atmel,mux-mask = <
>>  					/*   A          B          C  */
>>
> 
> 


-- 
Nicolas Ferre
