From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 04 Nov 2014 10:45:40 +0100
Subject: [PATCH v4 1/8] ARM: mediatek: Add basic support for mt8127
In-Reply-To: <CABuKBeL1JX88BBK7uXqpmaGzwCe5D6inB_n-NV6ajUt59V1swA@mail.gmail.com>
References: <1413973797-17619-1-git-send-email-yingjoe.chen@mediatek.com>
 <13477264.GuOdydWub7@wuerfel>
 <CABuKBeL1JX88BBK7uXqpmaGzwCe5D6inB_n-NV6ajUt59V1swA@mail.gmail.com>
Message-ID: <4360790.RbZnni9y9f@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 November 2014 09:36:39 Matthias Brugger wrote:
> 2014-11-04 8:39 GMT+01:00 Arnd Bergmann <arnd@arndb.de>:
> > On Tuesday 04 November 2014 14:36:45 HC Yen wrote:
> >> > > +
> >> > > +#include <dt-bindings/interrupt-controller/irq.h>
> >> > > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> >> > > +#include "skeleton64.dtsi"
> >> >
> >> > Cortex a7 is 32 bits, right? So why do you use skeleton64.dtsi?
> >>
> >> Cortex-A7 is 32-bit, but that doesn't mean it can only have 32-bit
> >> physical address.  With LPAE enabled, we can have physical address more
> >> than 32 bits.
> >>
> >> The main difference between "skeleton64.dtsi" and "skeleton.dtsi" is
> >> "#address-cells" property set to 2.  Although there are few sources
> >> using "skeleton64.dtsi", some of them write "#address-cells = <2>"
> >> directly in order to have 64-bit address space.  ARM's TC2 reference
> >> platform (vexpress-v2p-ca15_a7.dts) is an example.
> >>
> >> Some of MediaTek ARMv7 SoCs support address space larger than 4GB. It
> >> will be convenient to share the sources if we all use 64-bit device
> >> tree.
> >
> > Right, in general, I'd use #address-cells=<2> for Cortex-A7/A15/A17.
> 
> Alright, thanks for clarification. So we should use skeleton64.dtsi
> for mt6589 as well, right?

If the chip is capable of accessing memory or registers higher than 4GB
physical address, then you should, yes.

If the SoC has limitations that mean you can't have higher addresses
anyway, then either way is fine, no need to change it.

	Arnd
