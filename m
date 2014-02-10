From: Ying.Liu@freescale.com (Liu Ying)
Date: Mon, 10 Feb 2014 14:24:07 +0800
Subject: [PATCH] ARM: dts: i.MX51 babbage: Support diagnostic LED
In-Reply-To: <1392006579.703394606@f357.i.mail.ru>
References: <1391522263-17877-1-git-send-email-Ying.Liu@freescale.com>
 <20140210030214.GB9628@S2101-09.ap.freescale.net>
 <1392006579.703394606@f357.i.mail.ru>
Message-ID: <52F87087.4000908@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2014 12:29 PM, Alexander Shiyan wrote:
> ???????????, 10 ??????? 2014, 11:02 +08:00 ?? Shawn Guo <shawn.guo@linaro.org>:
>> On Tue, Feb 04, 2014 at 09:57:42PM +0800, Liu Ying wrote:
>>> The D25 LED controlled by gpio on the i.MX51 babbage
>>> board is a diagnostic LED according to the board design.
>>> This patch adds the relevant device tree nodes to the
>>> i.MX51 babbage device tree file to support this LED.
>>>
>>> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
>>> ---
>>>  arch/arm/boot/dts/imx51-babbage.dts |   17 +++++++++++++++++
>>>  1 file changed, 17 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/imx51-babbage.dts
>> b/arch/arm/boot/dts/imx51-babbage.dts
>>> index be1407c..8d6a74b 100644
>>> --- a/arch/arm/boot/dts/imx51-babbage.dts
>>> +++ b/arch/arm/boot/dts/imx51-babbage.dts
>>> @@ -81,6 +81,17 @@
>>>  		};
>>>  	};
>>>  
>>> +	leds {
>>> +		compatible = "gpio-leds";
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&led_pin_gpio2_6>;
>>> +
>>> +		led-diagnostic {
>>> +			label = "diagnostic";
>>> +			gpios = <&gpio2 6 0>;
>>
>> Just out of curiosity, how will you use/trigger the led?
> 
> And GPIO bindings should be used to specify active level,
> GPIO_ACTIVE_HIGH in this case.

Based on Linux 3.14-rc2, this gives me no single output:
grep GPIO_ACTIVE arch/arm/boot/dts/ -nr | grep imx

So, this patch follows the old approach.

I agree to use GPIO_ACTIVE_HIGH/GPIO_ACTIVE_LOW macros.
How about generating dedicated patch sets for this purpose?
Actually, I had one set for i.MX51 platforms.

Regards,
Liu Ying
