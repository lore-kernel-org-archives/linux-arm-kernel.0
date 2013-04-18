From: dmurphy@ti.com (Dan Murphy)
Date: Thu, 18 Apr 2013 13:31:11 -0500
Subject: [PATCHv2] ARM:dts:omap4-panda:Update the LED support for the
 panda DTS
In-Reply-To: <516FBD18.3060501@ti.com>
References: <1366229760-4808-1-git-send-email-dmurphy@ti.com>
 <516FBD18.3060501@ti.com>
Message-ID: <51703BEF.6050804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/2013 04:30 AM, Vincent Stehl? wrote:
> On 04/17/2013 10:16 PM, Dan Murphy wrote:
>> The GPIO for LED D1 on the omap4-panda a1-a3 rev and the omap4-panda-es
>> are different.
> (..)
>> diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
>> index 03bd60d..0c48f6b 100644
>> --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
>> +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
> (..)
>> @@ -135,6 +136,25 @@
>>   			0xf0 0x118     /* i2c4_sda PULLUP | INPUTENABLE | MODE0 */
>>   		>;
>>   	};
>> +
>> +	led_gpio_pins: pinmux_leds_pins {
>> +		pinctrl-single,pins = <
>> +		>;
>> +	};
>> +};
> Hi,
>
> FYI, there was a recent discussion precisely on this topic, where Tomy
> suggested to remove the empty section:
> http://marc.info/?l=linux-omap&m=136546635409232&w=2
>
> Apart from that, I just tested your patch on top of Tomy's
> omap-for-v3.10/dt branch and it is working fine for me on PandaBoards
> EA3, A4 and ES.
>
> Tested-by: Vincent Stehl? <v-stehle@ti.com>
>
> Best regards,
>
> V.
>
Thanks for testing Vincent

Is there a way to append the data to an already existing node?
I do not see a clean way.

Dan

-- 
----------------------------------------------
Dan Murphy
