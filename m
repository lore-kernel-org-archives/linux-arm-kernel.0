From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Jul 2016 10:32:30 +0200
Subject: [PATCH v2 2/2] spi: add DT binding for clps711x SPI
In-Reply-To: <1468398000.319627182@f165.i.mail.ru>
References: <20160707094952.4111577-1-arnd@arndb.de>
 <9132787.CoNHcRuYpT@wuerfel> <1468398000.319627182@f165.i.mail.ru>
Message-ID: <4424049.9GWmiGNCEh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 13, 2016 11:20:00 AM CEST Alexander Shiyan wrote:
> >?????, 13 ???? 2016, 11:13 +03:00 ?? Arnd Bergmann <arnd@arndb.de>:
> >
> >On Tuesday, July 12, 2016 3:49:47 PM CEST Rob Herring wrote:
> >> On Thu, Jul 07, 2016 at 11:49:46AM +0200, Arnd Bergmann wrote:
> >> > +
> >> > +An additional register is present in the system controller,
> >> > +which is assumed to be in the same device tree, with and marked
> >> > +as compatible with "cirrus,ep7209-syscon3".
> >> > +
> >> > +Example:
> >> > +
> >> > +spi at 80000500 {
> >> > +     #address-cells = <1>;
> >> > +     #size-cells = <0>;
> >> > +     compatible = "cirrus,ep7209-spi";
> >> > +     reg = <0x80000500 0x4>;
> >> > +     interrupts = <15>;
> >> > +     clocks = <&clks CLPS711X_CLK_SPI>;
> >> > +     status = "disabled";
> >> > +};
> >> > +
> >> > +syscon3: syscon at 80002200 {
> >> 
> >> This looks like it shouldn't be here.
> >
> >The label, or the entire node?
> 
> I think that the whole syscon3 node is redundant.

The node is needed here because it is required for the device to
work: the binding doesn't contain a label for the syscon reference
but as I documented above, any driver will have to look up the
syscon by compatible string.

	Arnd
