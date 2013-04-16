From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 16 Apr 2013 17:12:59 +0200
Subject: [PATCH 5/8] ARM: at91: sam9g45: add lcd support
In-Reply-To: <516D5991.8020603@atmel.com>
References: <20130411145741.GB25242@game.jcrosoft.org>
 <1365692422-9565-1-git-send-email-plagnioj@jcrosoft.com>
 <1365692422-9565-5-git-send-email-plagnioj@jcrosoft.com>
 <516D5991.8020603@atmel.com>
Message-ID: <516D6A7B.8050503@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2013 04:00 PM, Nicolas Ferre :
> On 04/11/2013 05:00 PM, Jean-Christophe PLAGNIOL-VILLARD :
>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>>  arch/arm/boot/dts/at91sam9g45.dtsi |   47 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 47 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
>> index 6b1d4ca..ab8a8fc 100644
>> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
>> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
>> @@ -322,6 +322,42 @@
>>  					};
>>  				};
>>  
>> +				fb {
>> +					pinctrl_fb: fb-0 {
>> +						atmel,pins =
>> +							<4 0 0x1 0x0	/* PE0 periph A */
>> +							 4 2 0x1 0x0	/* PE2 periph A */
>> +							 4 3 0x1 0x0	/* PE3 periph A */
>> +							 4 4 0x1 0x0	/* PE4 periph A */
>> +							 4 5 0x1 0x0	/* PE5 periph A */
>> +							 4 6 0x1 0x0	/* PE6 periph A */
>> +							 4 7 0x1 0x0	/* PE7 periph A */
>> +							 4 8 0x1 0x0	/* PE8 periph A */
>> +							 4 9 0x1 0x0	/* PE9 periph A */
>> +							 4 10 0x1 0x0	/* PE10 periph A */
>> +							 4 11 0x1 0x0	/* PE11 periph A */
>> +							 4 12 0x1 0x0	/* PE12 periph A */
>> +							 4 13 0x1 0x0	/* PE13 periph A */
>> +							 4 14 0x1 0x0	/* PE14 periph A */
>> +							 4 15 0x1 0x0	/* PE15 periph A */
>> +							 4 16 0x1 0x0	/* PE16 periph A */
>> +							 4 17 0x1 0x0	/* PE17 periph A */
>> +							 4 18 0x1 0x0	/* PE18 periph A */
>> +							 4 19 0x1 0x0	/* PE19 periph A */
>> +							 4 20 0x1 0x0	/* PE20 periph A */
>> +							 4 21 0x1 0x0	/* PE21 periph A */
>> +							 4 22 0x1 0x0	/* PE22 periph A */
>> +							 4 23 0x1 0x0	/* PE23 periph A */
>> +							 4 24 0x1 0x0	/* PE24 periph A */
>> +							 4 25 0x1 0x0	/* PE25 periph A */
>> +							 4 26 0x1 0x0	/* PE26 periph A */
>> +							 4 27 0x1 0x0	/* PE27 periph A */
>> +							 4 28 0x1 0x0	/* PE28 periph A */
>> +							 4 29 0x1 0x0	/* PE29 periph A */
>> +							 4 30 0x1 0x0>;	/* PE30 periph A */
>> +					};
>> +				};
>> +
>>  				pioA: gpio at fffff200 {
>>  					compatible = "atmel,at91rm9200-gpio";
>>  					reg = <0xfffff200 0x200>;
>> @@ -533,6 +569,17 @@
>>  			};
>>  		};
>>  
>> +		fb0: fb at 0x00500000 {
>> +			compatible = "atmel,at91sam9g45-lcdc";
>> +			reg = <0x00500000 0x1000>;
>> +			interrupts = <23 3 0>;
> 
> Error: here, it is <23 4 0>

Collecting all the remarks, we end-up with:

<23 4 3>

>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&pinctrl_fb>;
>> +			status = "disabled";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +		};
>> +
>>  		nand0: nand at 40000000 {
>>  			compatible = "atmel,at91rm9200-nand";
>>  			#address-cells = <1>;
>>
> 
> 


-- 
Nicolas Ferre
