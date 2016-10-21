From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 21 Oct 2016 12:26:40 +0200
Subject: [PATCH] dt/bindings: arm-boards: Remove skeleton.dtsi inclusion
 from example
In-Reply-To: <CAMuHMdVS3-xm+7gMkO59VtuN_pLAXSCNRBT1JekFE2cVbwngAQ@mail.gmail.com>
References: <1477041629-23341-1-git-send-email-geert+renesas@glider.be>
 <20161021094938.GB15372@leverpostej>
 <CAMuHMdVS3-xm+7gMkO59VtuN_pLAXSCNRBT1JekFE2cVbwngAQ@mail.gmail.com>
Message-ID: <CAMuHMdX6Gn7x09nup776VabkFXzWDfbqLaUPruLHgVVyT2Fgcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 12:16 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, Oct 21, 2016 at 11:50 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>> On Fri, Oct 21, 2016 at 11:20:29AM +0200, Geert Uytterhoeven wrote:
>>> --- a/Documentation/devicetree/bindings/arm/arm-boards
>>> +++ b/Documentation/devicetree/bindings/arm/arm-boards
>>> @@ -148,15 +148,14 @@ Example:
>>>
>>>  /dts-v1/;
>>>  #include <dt-bindings/interrupt-controller/irq.h>
>>> -#include "skeleton.dtsi"
>>>
>>>  / {
>>>       model = "ARM RealView PB1176 with device tree";
>>>       compatible = "arm,realview-pb1176";
>>> +     #address-cells = <0>;

How did I manage to turn the <1> into a <0> by moving and reindenting
two lines?!? Will fix, too.

>>> +     #size-cells = <1>;
>>>
>>>       soc {
>>> -             #address-cells = <1>;
>>> -             #size-cells = <1>;
>>
>> Strictly speaking, these two are still necessary for the ranges
>> property. They're *not* inherited per the spec, no matter what Linux
>> happens to do today.
>
> I wasn't sure about that part of the change. OK, will fix.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
