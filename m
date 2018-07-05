From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Thu, 5 Jul 2018 12:05:28 +0200
Subject: [PATCH v2 18/23] dt-bindings: thermal: armada: add reference to
 new bindings
In-Reply-To: <20180703213011.GA13190@rob-hp-laptop>
References: <20180625151239.20976-1-miquel.raynal@bootlin.com>
 <20180625151239.20976-19-miquel.raynal@bootlin.com>
 <20180703213011.GA13190@rob-hp-laptop>
Message-ID: <20180705120528.4b923e16@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Rob Herring <robh@kernel.org> wrote on Tue, 3 Jul 2018 15:30:11 -0600:

> On Mon, Jun 25, 2018 at 05:12:34PM +0200, Miquel Raynal wrote:
> > New bindings (with the syscon and the overheat interrupt) are available  
> 
> What interrupt? It's not in your new binding.
> 
> > for AP806 and CP110 compatibles. Add a reference to these files from the
> > original documentation.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/thermal/armada-thermal.txt | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > index e0d013a2e66d..f3b441100890 100644
> > --- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > +++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > @@ -10,6 +10,11 @@ Required properties:
> >      * marvell,armada-ap806-thermal
> >      * marvell,armada-cp110-thermal  
> 
> Really you should not be using the same compatible for both. Now you 
> have 2 drivers matching to same compatibles.
> 
> Can't you make this a child of the syscon without breaking the binding?

We are talking about only 1 driver here, so I'm not sure how I should
understand your last sentence. Do you want me to add a second
compatible (for the same piece of hardware) for thermal node declared
as a child of the syscon?

I could handle this situation in the driver by creating the missing
regmap in case we are using the old compatible. If this is the solution
you prefer, how should I name the new compatibles ?

> 
> >  
> > +Note: these bindings are deprecated for AP806/CP110 and should instead
> > +follow the rules described in:
> > +Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> > +Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
> > +
> >  - reg: Device's register space.
> >    Two entries are expected, see the examples below. The first one points
> >    to the status register (4B). The second one points to the control
> > -- 
> > 2.14.1
> >   

Thanks,
Miqu?l
