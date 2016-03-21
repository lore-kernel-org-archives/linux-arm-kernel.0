From: marex@denx.de (Marek Vasut)
Date: Mon, 21 Mar 2016 11:14:31 +0100
Subject: [PATCH 1/2] ARM: socfpga: Add support for HPS LEDs on SoCKit
In-Reply-To: <73y49cl178.fsf@unicorn.hi.pengutronix.de>
References: <1458431866-9269-1-git-send-email-marex@denx.de>
 <73y49cl178.fsf@unicorn.hi.pengutronix.de>
Message-ID: <56EFC987.2050502@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2016 08:50 AM, Steffen Trumtrar wrote:
> 
> Hi!

Hi!

> Marek Vasut writes:
> 
>> Add support for the blue LEDs on the SoCFPGA SoCkit board.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
>> ---
>>  arch/arm/boot/dts/socfpga_cyclone5_sockit.dts | 32 +++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
>> index b61f22f..1461690 100644
>> --- a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
>> +++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
>> @@ -39,6 +39,34 @@
>>  		ethernet0 = &gmac1;
>>  	};
>>  
>> +	leds {
>> +		compatible = "gpio-leds";
>> +
>> +		hps_led0 {
>> +			label = "hps:blue:led0";
>> +			gpios = <&portb 24 0>;	/* HPS_GPIO53 */
>> +			linux,default-trigger = "heartbeat";
>> +		};
>> +
>> +		hps_led1 {
>> +			label = "hps:blue:led1";
>> +			gpios = <&portb 25 0>;	/* HPS_GPIO54 */
>> +			linux,default-trigger = "heartbeat";
>> +		};
>> +
>> +		hps_led2 {
>> +			label = "hps:blue:led2";
>> +			gpios = <&portb 26 0>;	/* HPS_GPIO55 */
>> +			linux,default-trigger = "heartbeat";
>> +		};
>> +
>> +		hps_led3 {
>> +			label = "hps:blue:led3";
>> +			gpios = <&portb 27 0>;	/* HPS_GPIO56 */
>> +			linux,default-trigger = "heartbeat";
>> +		};
>> +	};
>> +
> 
> I'd personally remove the default-triggers.

At least the LEDs appear to do something and are not completely dead,
but either way is fine with me. The heartbeat effect is also not amusing.

> Otherwise looks good to me.

Thanks for the review :)

-- 
Best regards,
Marek Vasut
