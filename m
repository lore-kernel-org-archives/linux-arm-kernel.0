From: cavokz@gmail.com (Domenico Andreoli)
Date: Wed, 10 Oct 2012 00:58:37 +0200
Subject: [PATCH 1/6] ARM: bcm476x: Add infrastructure
In-Reply-To: <201210090918.56725.arnd@arndb.de>
References: <20121007015300.828366635@gmail.com>
 <20121007015405.958959522@gmail.com>
 <201210090918.56725.arnd@arndb.de>
Message-ID: <20121009225837.GA7758@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2012 at 09:18:56AM +0000, Arnd Bergmann wrote:
> Hi Domenico,

Hello,

> Your series looks very nice, thanks for the contribution!

hehe.. thanks also to the hard work committed in the ARM sub-tree in these
past (few!) months.

> Stephen has already covered everything I would have commented and
> more, except for one thing that I found:
>
> On Sunday 07 October 2012, Domenico Andreoli wrote:
> > Index: b/arch/arm/boot/dts/bcm476x.dtsi
> > ===================================================================
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/bcm476x.dtsi
> > @@ -0,0 +1,31 @@
> > +/include/ "skeleton.dtsi"
> > +
> > +/ {
> > +       compatible = "brcm,bcm476x";
> > +       model = "Broadcom BCM476x";
> > +
> > ...
> > +               vic0: interrupt-controller at 80000 {
> > +                       compatible = "brcm,bcm476x-pl192", "arm,pl192-vic", "arm,primecell";
> > +                       reg = <0x80000 0x1000>;
> > +                       interrupt-controller;
> > +                       #interrupt-cells = <1>;
> > +               };
>
> I suppose that the name of the soc is not actually "bcm476x" but you
> are in fact referring to the family including bcm4760 and bcm4761.

Yes, those two.

> The convention in the device tree is to always use specific product
> numbers, rather than wildcards. If one of the two has a superset of
> the hardware of the other, I would recommend you pick that number
> in the device tree and in the drivers, and for the other one, you
> just mark them as compatible to both of them.

bcm4760 is the superset (bcm4761 hasn't the gpu) but there are also other
differences (that I know, USB phy and clocks).

I can identify the SoC at runtime, does this change anything to your
recommendation?

Thanks for the feedback.

Regards,
Domenico
