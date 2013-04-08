From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Mon, 8 Apr 2013 14:15:39 +0200 (CEST)
Subject: [PATCH v3] irqchip: renesas-intc-irqpin: DT binding for sense
 bitfield width
In-Reply-To: <15518520.KQOfZxAAdo@avalon>
References: <Pine.LNX.4.64.1304081002190.29945@axis700.grange>
 <1694336.shM2ct4pzX@avalon> <Pine.LNX.4.64.1304081324370.29945@axis700.grange>
 <15518520.KQOfZxAAdo@avalon>
Message-ID: <Pine.LNX.4.64.1304081412550.29945@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 8 Apr 2013, Laurent Pinchart wrote:

> Hi Guennadi,
> 
> On Monday 08 April 2013 13:25:46 Guennadi Liakhovetski wrote:
> > On Mon, 8 Apr 2013, Laurent Pinchart wrote:
> > > On Monday 08 April 2013 10:08:40 Guennadi Liakhovetski wrote:
> > > > Most Renesas irqpin controllers have 4-bit sense fields, however, some
> > > > have different widths. This patch adds a DT binding to optionally
> > > > specify such non-standard values.
> > > > 
> > > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > > > ---
> > > > 
> > > > v3: move the code to a common location, where device configuration
> > > > parameters are retrieved
> > > > 
> > > >  .../interrupt-controller/renesas,intc-irqpin.txt   |   13 +++++++++++++
> > > >  drivers/irqchip/irq-renesas-intc-irqpin.c          |    4 ++++
> > > >  2 files changed, 17 insertions(+), 0 deletions(-)
> > > >  create mode 100644
> > > > 
> > > > Documentation/devicetree/bindings/interrupt-controller/renesas,intc-
> > > > irqpin.txt
> > > > diff --git a/Documentation/devicetree/bindings/interrupt-
> > > > controller/renesas,intc-irqpin.txt
> > > > b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-
> > > > irqpin.txt
> > > > new file mode 100644
> > > > index 0000000..c6f09b7
> > > > --- /dev/null
> > > > +++
> > > > b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-
> > > > irqpin.txt
> > > > @@ -0,0 +1,13 @@
> > > > +DT bindings for the R-/SH-Mobile irqpin controller
> > > > +
> > > > +Required properties:
> > > > +
> > > > +- compatible: has to be "renesas,intc-irqpin"
> > > > +- #interrupt-cells: has to be <2>
> > > > +
> > > > +Optional properties:
> > > > +
> > > > +- any properties, listed in interrupts.txt in this directory, and any
> > > > standard
> > > > +  resource allocation properties
> > > > +- sense-bitfield-width: width of a single sense bitfield in the SENSE
> > > > register,
> > > > +  if different from the default 4 bits
> > > 
> > > Wouldn't it be better to define per-SoC compatible strings, and infer the
> > > sense bitfield width from that ?
> > 
> > This is not a boolean, it is an integer, I don't think defining
> > compatibility strings for 1, 2, 3, 4, 5,... bits is better than having one
> > integer property.
> 
> I'm not advocating for compatibility strings for a given number of bits, but 
> for per-SoC compatibility strings from which to infer the width.
> 
> For instance, if the r8a7779 has a 6-bit sense field, you would use
> 
> compatible = "r8a7779,intc-irqpin";
> 
> and map that to 6 in the irqpin driver.

I understand what you mean, still I don't think mapping N 
SoC-compatibility strings to various values of a single integer is better 
than having a single property.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
