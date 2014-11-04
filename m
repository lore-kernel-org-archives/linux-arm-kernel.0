From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 4 Nov 2014 09:36:39 +0100
Subject: [PATCH v4 1/8] ARM: mediatek: Add basic support for mt8127
In-Reply-To: <13477264.GuOdydWub7@wuerfel>
References: <1413973797-17619-1-git-send-email-yingjoe.chen@mediatek.com>
 <CABuKBeLYMbD-dV_25FJd_NE1RgfVkgF+SoCiAx9O9jKUUAcexA@mail.gmail.com>
 <1415083006.10186.85.camel@mtksdaap41>
 <13477264.GuOdydWub7@wuerfel>
Message-ID: <CABuKBeL1JX88BBK7uXqpmaGzwCe5D6inB_n-NV6ajUt59V1swA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-04 8:39 GMT+01:00 Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 04 November 2014 14:36:45 HC Yen wrote:
>> > > +
>> > > +#include <dt-bindings/interrupt-controller/irq.h>
>> > > +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> > > +#include "skeleton64.dtsi"
>> >
>> > Cortex a7 is 32 bits, right? So why do you use skeleton64.dtsi?
>>
>> Cortex-A7 is 32-bit, but that doesn't mean it can only have 32-bit
>> physical address.  With LPAE enabled, we can have physical address more
>> than 32 bits.
>>
>> The main difference between "skeleton64.dtsi" and "skeleton.dtsi" is
>> "#address-cells" property set to 2.  Although there are few sources
>> using "skeleton64.dtsi", some of them write "#address-cells = <2>"
>> directly in order to have 64-bit address space.  ARM's TC2 reference
>> platform (vexpress-v2p-ca15_a7.dts) is an example.
>>
>> Some of MediaTek ARMv7 SoCs support address space larger than 4GB. It
>> will be convenient to share the sources if we all use 64-bit device
>> tree.
>
> Right, in general, I'd use #address-cells=<2> for Cortex-A7/A15/A17.

Alright, thanks for clarification. So we should use skeleton64.dtsi
for mt6589 as well, right?

>
>         Arnd



-- 
motzblog.wordpress.com
