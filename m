From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 19 Jul 2013 22:18:56 +0400
Subject: [PATCH v6 1/2] ARM: dts: twl: Add GPADC data to device tree
In-Reply-To: <51E95DEB.7010702@ti.com>
References: <1374226039-16943-1-git-send-email-oleksandr.kozaruk@ti.com>
 <1374226039-16943-2-git-send-email-oleksandr.kozaruk@ti.com>
 <51E94F97.40002@cogentembedded.com> <51E95DEB.7010702@ti.com>
Message-ID: <51E98310.7020103@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/19/2013 07:40 PM, Grygorii Strashko wrote:

>>> GPADC is the general purpose ADC present on twl6030.
>>> The dt data is interrupt used to trigger end of ADC
>>> conversion.

>>> Signed-off-by: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
>>> ---
>>>   arch/arm/boot/dts/twl6030.dtsi | 6 ++++++
>>>   1 file changed, 6 insertions(+)

>>> diff --git a/arch/arm/boot/dts/twl6030.dtsi
>>> b/arch/arm/boot/dts/twl6030.dtsi
>>> index 2e3bd31..d7d4c28 100644
>>> --- a/arch/arm/boot/dts/twl6030.dtsi
>>> +++ b/arch/arm/boot/dts/twl6030.dtsi
>>> @@ -103,4 +103,10 @@
>>>           compatible = "ti,twl6030-pwmled";
>>>           #pwm-cells = <2>;
>>>       };
>>> +
>>> +    adc: gpadc {

>>     Read my lips: the node should be called just "adc", not "gpadc".
>        ^^^^^^^^^^^^ Are you sure?

    I didn't know how to express my disappointment from Oleksandr's inability 
to understand what I wanted to convey to him from 2 attempts... first, he 
changed the label instead of the node name, then he only dropped "twl6030_" 
prefix from the name. I should probably have been even more specific before.

> Why? The name was selected according to the documentation on device "General
> purpose analog-to-digital converter (GPADC)".

    Sigh, we simply don't care whether this ADC is general-purpose or not.
The main thing it is ADC.

> PS. Following your logic - "GPIO" need to renamed to "IO" everywhere ;P

    GPIO is well known and established abbreviation, contrasted to GPADC.
Moreover, ePAPR spec lists "gpio" as a generic node name.

WBR, Sergei
