From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Jul 2016 09:46:50 +0200
Subject: [PATCH v2 09/10] Documentation: devicetree: Add dts description
 for nuc900
In-Reply-To: <578300E2.5000405@iommu.org>
References: <1468136542-2656-1-git-send-email-vw@iommu.org>
 <1850749.ap1S8Xq0fA@wuerfel> <578300E2.5000405@iommu.org>
Message-ID: <1644086.jqpXDrkuq8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 11, 2016 10:13:54 AM CEST Wan Zongshun wrote:
> 
> On 2016?07?11? 06:17, Arnd Bergmann wrote:
> > On Sunday, July 10, 2016 3:42:21 PM CEST Wan Zongshun wrote:
> >> +
> >> +Required properties:
> >> +- compatible : Should be "nuvoton,nuc970-tmr"
> >> +- reg : Address and length of the register set
> >> +- clocks : Reference on the timer input clock
> >> +- interrupts : Reference to the timer interrupt
> >> +
> >> +Example:
> >> +
> >> +tmr at 0xb8001000 {
> >
> > The name should be "timer", not "tmr", and the address should
> > not contain a leading "0x".
> 
> Ok, so all dts addresses has no need contain a leading "0x"?

In properties, you need the leading 0x for hexadecimal numbers,
in the node name the portion after the "@" depends on the bus,
but is usually just the value of the address in hexadecimal
without the leading 0x.

> >
> >> +       compatible = "nuvoton,nuc970-tmr";
> >> +       reg = <0xb8001000 0x1000>;
> >> +       interrupts = <16>;
> >> +       clocks = <&clks TIMER0_GATE>,
> >> +       <&clks TIMER1_GATE>;
> >> +       clock-names = "timer0", "timer1";
> >> +};
> >
> > The clocks/clock-names description does not match the example:
> > you only define a single clock in the required properties, but
> > have two separate inputs in the example. Please fix one or the
> > other.
> 
> Two clocks are necessary, so I only need modify this description like?
> 
> Required properties:
>    clocks : Reference on the timer input clock, This list should be 2
> 	   clocks, the order is timer0 , timer1.
> 
> Is it ok?

Yes, looks good.

	Arnd
