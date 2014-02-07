From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 7 Feb 2014 11:22:31 +0100
Subject: [PATCH v3 06/15] at91: dt: at91sam9261ek: Adds DT entries for
 the 4 user buttons
In-Reply-To: <CACh+v5O_CMcYKBKLzbcD2ypGLX_Pp+64fiqO4MWYw-J4h0KA7A@mail.gmail.com>
References: <1390492639-7299-1-git-send-email-jjhiblot@traphandler.com>	<1390492639-7299-7-git-send-email-jjhiblot@traphandler.com>	<20140207082752.GV9558@ns203013.ovh.net>
 <CACh+v5O_CMcYKBKLzbcD2ypGLX_Pp+64fiqO4MWYw-J4h0KA7A@mail.gmail.com>
Message-ID: <52F4B3E7.2080000@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/2014 10:30, Jean-Jacques Hiblot :
> 2014-02-07 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>:
>> On 16:57 Thu 23 Jan     , Jean-Jacques Hiblot wrote:
>>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>>> ---
>>>  arch/arm/boot/dts/at91sam9261ek.dts | 39 +++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 39 insertions(+)
>>
>> do only one patch for the 9261ek support no nned to clean
>>>
>>> diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
>>> index 8909217..5555e9f5 100644
>>> --- a/arch/arm/boot/dts/at91sam9261ek.dts
>>> +++ b/arch/arm/boot/dts/at91sam9261ek.dts
>>> @@ -83,6 +83,15 @@
>>>                                               AT91_PIOA 23  AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
>>>                                       };
>>>                               };
>>> +
>>> +                             keys {
>>> +                                     pinctrl_keys: keys-0 {
>>> +                                             atmel,pins = <AT91_PIOA 27  AT91_PERIPH_GPIO AT91_PINCTRL_NONE
>>> +                                             AT91_PIOA 26  AT91_PERIPH_GPIO AT91_PINCTRL_NONE
>>> +                                             AT91_PIOA 25  AT91_PERIPH_GPIO AT91_PINCTRL_NONE
>>> +                                             AT91_PIOA 24  AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
>>> +                                     };
>>> +                             };
>>
>> no need this you can drop it
> ok. I thought that it would help the user to understand the GPIO usage.
> I'll remove all pinmux for GPIO that don't require a special hardware
> configuration

Well, me also, I like to see what the board requires for functioning
properly. It is convenient for:
- understanding clearly what is used and what is not
- doing a grep when searching where a particular GPIO is used
- describing completely the hardware (which is the purpose of DT)

So, I would like additional consideration by more AT91 users before
following this rule... And maybe a note by Linus W.

Bye,


>>
>> you just describe a gpio which we do not describe in pinctrl
>>>                       };
>>>
>>>                       watchdog at fffffd40 {
>>> @@ -109,4 +118,34 @@
>>>                       linux,default-trigger = "heartbeat";
>>>               };
>>>       };
>>> +
>>> +     gpio_keys {
>>> +             compatible = "gpio-keys";
>>> +             pinctrl-0 = <&pinctrl_keys>;
>>> +
>>> +             button_0 {
>>> +                     label = "button_0";
>>> +                     gpios = <&pioA 27 GPIO_ACTIVE_LOW>;
>>> +                     linux,code = <256>;
>>> +                     gpio-key,wakeup;
>>> +             };
>>> +             button_1 {
>>> +                     label = "button_1";
>>> +                     gpios = <&pioA 26 GPIO_ACTIVE_LOW>;
>>> +                     linux,code = <257>;
>>> +                     gpio-key,wakeup;
>>> +             };
>>> +             button_2 {
>>> +                     label = "button_2";
>>> +                     gpios = <&pioA 25 GPIO_ACTIVE_LOW>;
>>> +                     linux,code = <258>;
>>> +                     gpio-key,wakeup;
>>> +             };
>>> +             button_3 {
>>> +                     label = "button_3";
>>> +                     gpios = <&pioA 24 GPIO_ACTIVE_LOW>;
>>> +                     linux,code = <259>;
>>> +                     gpio-key,wakeup;
>>> +             };
>>> +     };
>>>  };
>>> --
>>> 1.8.5.2
>>>
> 
> 


-- 
Nicolas Ferre
