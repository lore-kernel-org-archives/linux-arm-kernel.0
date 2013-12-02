From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 2 Dec 2013 13:47:29 +0100
Subject: [PATCH] ARM: at91: add usart3 alias to dtsi
In-Reply-To: <529C70C7.9050707@overkiz.com>
References: <1385979186-29447-1-git-send-email-nicolas.ferre@atmel.com>
 <529C70C7.9050707@overkiz.com>
Message-ID: <529C8161.5050005@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2013 12:36, boris brezillon :
> Hi Nicolas,
>
> Le 02/12/2013 11:13, Nicolas Ferre a ?crit :
>> Alias was missing for SoC of the at91sam9x5 familly that embed USART3.
>> Preripheral node and pinctrl declarations are already in the
>> at91sam9x5_usart3.dtsi file.
>>
>> Reported-by: Jiri Prchal <jiri.prchal@aksignal.cz>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>>    arch/arm/boot/dts/at91sam9g25.dtsi | 4 ++++
>>    arch/arm/boot/dts/at91sam9x25.dtsi | 4 ++++
>>    2 files changed, 8 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/at91sam9g25.dtsi b/arch/arm/boot/dts/at91sam9g25.dtsi
>> index 17b879990914..d4650b4e9ebb 100644
>> --- a/arch/arm/boot/dts/at91sam9g25.dtsi
>> +++ b/arch/arm/boot/dts/at91sam9g25.dtsi
>> @@ -14,6 +14,10 @@
>>    	model = "Atmel AT91SAM9G25 SoC";
>>    	compatible = "atmel,at91sam9g25", "atmel,at91sam9x5";
>>
>> +	aliases {
>> +		serial4 = &usart3;
>> +	};
>> +
>
> Shouldn't this go into at91sam9x5_usart3.dtsi ?
> This way you would have the same alias for all the SoCs supporting usart3.

Indeed, I was focused on the product itself but it definitively makes 
sense to move it in the at91sam9x5_usart3.dtsi

Thanks, bye,


>>    	ahb {
>>    		apb {
>>    			pinctrl at fffff400 {
>> diff --git a/arch/arm/boot/dts/at91sam9x25.dtsi b/arch/arm/boot/dts/at91sam9x25.dtsi
>> index c2554219f7a4..aceee86f60eb 100644
>> --- a/arch/arm/boot/dts/at91sam9x25.dtsi
>> +++ b/arch/arm/boot/dts/at91sam9x25.dtsi
>> @@ -15,6 +15,10 @@
>>    	model = "Atmel AT91SAM9X25 SoC";
>>    	compatible = "atmel,at91sam9x25", "atmel,at91sam9x5";
>>
>> +	aliases {
>> +		serial4 = &usart3;
>> +	};
>> +
>>    	ahb {
>>    		apb {
>>    			pinctrl at fffff400 {
>
>
>


-- 
Nicolas Ferre
