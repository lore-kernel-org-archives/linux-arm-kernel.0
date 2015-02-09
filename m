From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 9 Feb 2015 18:23:29 +0800
Subject: [PATCH 3/3] ARM: at91: dt: at91sam9n12ek: enable udp
In-Reply-To: <20150209100404.GA17242@gradator.net>
References: <1423472572-19824-1-git-send-email-voice.shen@atmel.com>
 <1423472572-19824-4-git-send-email-voice.shen@atmel.com>
 <20150209100404.GA17242@gradator.net>
Message-ID: <54D88AA1.3020402@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylvain,

On 02/09/2015 06:04 PM, Sylvain Rochet wrote:
> Hello Bo,
>
> On Mon, Feb 09, 2015 at 05:02:52PM +0800, Bo Shen wrote:
>> Enable usb device port on at91sam9n12ek board.
>>
>> Signed-off-by: Bo Shen <voice.shen@atmel.com>
>> ---
>>
>>   arch/arm/boot/dts/at91sam9n12ek.dts | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
>> index 13bb24e..3e572e5 100644
>> --- a/arch/arm/boot/dts/at91sam9n12ek.dts
>> +++ b/arch/arm/boot/dts/at91sam9n12ek.dts
>> @@ -120,6 +120,11 @@
>>   				};
>>   			};
>>
>> +			usb1: gadget at f803c000 {
>> +				atmel,vbus-gpio = <&pioB 16 GPIO_ACTIVE_HIGH>;
>> +				status = "okay";
>> +			};
>> +
>
> There is an external resistor divider on PB16, acting like a pull-down
> (R22+R23). PB16 reset state is input, pull-up, schmitt trigger, you need
> to disable the pull-up in pinctrl this way:
>
> usb1: gadget at f803c000 {
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&pinctrl_board_usb1>;
> 	?
> }
>
> pinctrl ? {
> 	usb1 {
> 		pinctrl_board_usb1: usb1-board {
> 			atmel,pins = <AT91_PIOB 16 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;    /* PB16, no pull up and deglitch */
> 		};
> 	};
> };

Thanks.

I will add it in next version.

>
> Sylvain
>

Best Regards,
Bo Shen
