From: bart.tanghe@thomasmore.be (Bart Tanghe)
Date: Wed, 14 Jan 2015 09:16:31 +0100
Subject: [PATCH]dts: add bcm2835-pwm bindings
In-Reply-To: <54B54597.3010508@wwwdotorg.org>
References: <1420471983-29945-1-git-send-email-bart.tanghe@thomasmore.be>
 <54B1556C.7070401@wwwdotorg.org> <54B53C86.4030903@thomasmore.be>
 <54B54597.3010508@wwwdotorg.org>
Message-ID: <54B625DF.4030801@thomasmore.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2015 05:19 PM, Stephen Warren wrote:
> On 01/13/2015 08:40 AM, Bart Tanghe wrote:
>> On 01/10/2015 05:38 PM, Stephen Warren wrote:
>>> On 01/05/2015 08:33 AM, Bart Tanghe wrote:
>>>> To probe the bcm2835-pwm driver properly, this dts bindings has to be added
>>>> to the bcm2835 dtsi file.
>>>> In expectation of a bcm2835 clock driver, I've added fixed-clock clock binding.
>>>> To change the status of the gpio pins into pwm output pins, some additional
>>>> bindings has to be added but this has not to be done automatically.
>>>> Is it possible to document this bindings somewhere?
>>>
>>> The pinctrl bindings allow you to do this. They're documented in:
>>>
>>> Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
>>> Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt
>>>
>>> pinctrl setup would typically be added to the board file (i.e.
>>> arch/arm/boot/dts/bcm2835-rpi-b.dts) rather than the SoC file. I think
>>> on the RPi, the pins that can generate PWM aren't dedicated to PWM by
>>> the RPi board design (they could be GPIOs and probably other functions
>>> too) so we probably need to leave it up to individual users to add PWM
>>> configuration to their DT, if/when they use the PWM feature.
>>>
>>
>> Indeed, the pins aren't dedicated to pwm and can be used for other functions.
>> Is it usefull to add  the pwm pinctrl description to
>> Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt or is this
>> useless?
> 
> As far as I can tell, that file already describes everything required to configure those pins as PWM (or indeed any pins as any function). Can you expand on what you think is missing?
Indeed, everything is described in the file. I thought about a specific pwm pinctrl section but it's the same for i2c and spi. This will just make the file unclear. 
No need to add documentation.

Regards,

Bart
