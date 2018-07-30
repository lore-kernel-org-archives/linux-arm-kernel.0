From: codrin.ciubotariu@microchip.com (Codrin Ciubotariu)
Date: Mon, 30 Jul 2018 17:03:33 +0300
Subject: [PATCH v6 3/3] ARM: dts: at91: sama5d2 Xplained: add pin muxing
 for I2S
In-Reply-To: <2e2bc99e-138e-fbc8-1db0-e37b46637af0@microchip.com>
References: <20180730114008.30464-1-codrin.ciubotariu@microchip.com>
 <20180730114008.30464-4-codrin.ciubotariu@microchip.com>
 <2e2bc99e-138e-fbc8-1db0-e37b46637af0@microchip.com>
Message-ID: <f11c6e5d-b6a4-2c06-ed7b-abdf19ade257@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.07.2018 16:49, Claudiu Beznea wrote:
> Hi Codrin,
> 
> On 30.07.2018 14:40, Codrin Ciubotariu wrote:
>> From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
>>
>> This patch sets the pin muxing for the I2S controllers
>>
>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
>> [codrin.ciubotariu at microchip.com: added pin muxing for the second
>> controller]
>> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
>> ---
>>
>> Changes in v6:
>> 	- none;
>>
>>   arch/arm/boot/dts/at91-sama5d2_xplained.dts | 28 +++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
>> index fcc85d70f36e..95cbec0f8790 100644
>> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
>> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
>> @@ -281,6 +281,11 @@
>>   				status = "okay";
>>   			};
>>   
>> +			i2s0: i2s at f8050000 {
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&pinctrl_i2s0_default>;
> 
> The approach with the disabled controllers in board DTS files (for our
> boards) is to use the: status = "disabled" and if there are pin conflicts
> with other controllers to put a mark in there, something like:
> 				status = "disabled"; /* Conflict with X */
> 
> I'm seeing that i2s1 is in conflict with sdmmc1 and spi0.

Ok, I will disable them and add the pin conflicts in the next version. 
Thank you for your review.

Best regards,
Codrin
