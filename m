From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 21 Oct 2016 12:16:53 +0200
Subject: [PATCH] dt/bindings: arm-boards: Remove skeleton.dtsi inclusion
 from example
In-Reply-To: <20161021094938.GB15372@leverpostej>
References: <1477041629-23341-1-git-send-email-geert+renesas@glider.be>
 <20161021094938.GB15372@leverpostej>
Message-ID: <CAMuHMdVS3-xm+7gMkO59VtuN_pLAXSCNRBT1JekFE2cVbwngAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Fri, Oct 21, 2016 at 11:50 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Oct 21, 2016 at 11:20:29AM +0200, Geert Uytterhoeven wrote:
>> As of commit 9c0da3cc61f1233c ("ARM: dts: explicitly mark skeleton.dtsi
>> as deprecated"), including skeleton.dtsi is deprecated.
>> Hence remove it from the example.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  Documentation/devicetree/bindings/arm/arm-boards | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentation/devicetree/bindings/arm/arm-boards
>> index ab318a56fca2194f..e667ecbcf226dfe3 100644
>> --- a/Documentation/devicetree/bindings/arm/arm-boards
>> +++ b/Documentation/devicetree/bindings/arm/arm-boards
>> @@ -148,15 +148,14 @@ Example:
>>
>>  /dts-v1/;
>>  #include <dt-bindings/interrupt-controller/irq.h>
>> -#include "skeleton.dtsi"
>>
>>  / {
>>       model = "ARM RealView PB1176 with device tree";
>>       compatible = "arm,realview-pb1176";
>> +     #address-cells = <0>;
>> +     #size-cells = <1>;
>>
>>       soc {
>> -             #address-cells = <1>;
>> -             #size-cells = <1>;
>
> Strictly speaking, these two are still necessary for the ranges
> property. They're *not* inherited per the spec, no matter what Linux
> happens to do today.

I wasn't sure about that part of the change. OK, will fix.

> With those restored:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
