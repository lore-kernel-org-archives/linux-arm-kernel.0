From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Nov 2016 12:51:27 +0100
Subject: [PATCH] dt-bindings: mfd: Improve readability for TPS65217
 interrupt sources
In-Reply-To: <bd4944d8-3cef-b3f7-4fba-6de590493047@gmail.com>
References: <20161121131515.8040-1-woogyom.kim@gmail.com>
 <20161122155759.GG10134@dell.home>
 <bd4944d8-3cef-b3f7-4fba-6de590493047@gmail.com>
Message-ID: <33562327.jVWx4tN2gP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 23, 2016 8:38:00 PM CET Milo Kim wrote:
> On 11/23/2016 12:57 AM, Lee Jones wrote:
> >>      pwrbutton {
> >> > -          interrupts = <TPS65217_IRQ_PB>;
> >> > +          interrupts = <TPS65217_IRQ_PUSHBUTTON>;
> > Push button or power button?
> >
> 
> According to the datasheet, push button interrupt is correct.
> 
>         http://www.ti.com/lit/ds/symlink/tps65217.pdf
> 
> This is used for a power button input in Beaglebone boards. In other 
> words, the power button is one of push button usages.
> 
> So, I'd like to keep general name for the interrupt.

Ah, the numbers come from the data sheet. Please just remove the
header then, there is no need to keep them as an ABI, in particular
when the driver doesn't even include that header today.

I see you even have names for them in the node:

        charger {
-               interrupts = <TPS65217_IRQ_AC>, <TPS65217_IRQ_USB>;
+               interrupts = <TPS65217_IRQ_AC_POWER>, <TPS65217_IRQ_USB_POWER>;
                interrupts-names = "AC", "USB";
                status = "okay";

What matters here is the binding documentation in
Documentation/devicetree/bindings/power/supply/tps65217_charger.txt

Please fix that instead to mandate that the two interrupts are
required, what their functions are, and what the interrupt-names
(not interrupts-names) property must list.

	Arnd
