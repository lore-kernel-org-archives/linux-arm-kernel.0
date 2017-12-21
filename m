From: prabhakar.kushwaha@nxp.com (Prabhakar Kushwaha)
Date: Thu, 21 Dec 2017 08:09:41 +0000
Subject: [PATCH][v3] dt-bindings: ifc: Update endianness usage
In-Reply-To: <HE1PR04MB12413F48FF7E083FD8E0FD36973D0@HE1PR04MB1241.eurprd04.prod.outlook.com>
References: <1512029196-7158-1-git-send-email-prabhakar.kushwaha@nxp.com>
 <20171204204727.fnt4vsw2lg2q2w5x@rob-hp-laptop>
 <HE1PR04MB12413F48FF7E083FD8E0FD36973D0@HE1PR04MB1241.eurprd04.prod.outlook.com>
Message-ID: <HE1PR04MB1241224F0F7DC884338F2D26970D0@HE1PR04MB1241.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

> -----Original Message-----
> From: devicetree-owner at vger.kernel.org [mailto:devicetree-
> owner at vger.kernel.org] On Behalf Of Prabhakar Kushwaha
> Sent: Tuesday, December 05, 2017 2:45 PM
> To: Rob Herring <robh@kernel.org>
> Cc: devicetree at vger.kernel.org; mark.rutland at arm.com;
> shawnguo at kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH][v3] dt-bindings: ifc: Update endianness usage
> 
> 
> > -----Original Message-----
> > From: Rob Herring [mailto:robh at kernel.org]
> > Sent: Tuesday, December 05, 2017 2:17 AM
> > To: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
> > Cc: devicetree at vger.kernel.org; mark.rutland at arm.com;
> > shawnguo at kernel.org; linux-arm-kernel at lists.infradead.org
> > Subject: Re: [PATCH][v3] dt-bindings: ifc: Update endianness usage
> >
> > On Thu, Nov 30, 2017 at 01:36:36PM +0530, Prabhakar Kushwaha wrote:
> > > IFC controller version < 2.0 support IFC register access as
> > > big endian. These controller version also require IFC NOR signals to
> > > be connected in reverse order with NOR flash.
> > >
> > > IFC >= 2.0 is other way around.
> > >
> > > So updating IFC binding to take care of both using endianness field.
> > >
> > > Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
> > > ---
> > > Changes for v2: updated subject
> > > Changes for v3: fixed typo for "big-endian"
> > >
> > >  Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt | 6
> ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/memory-
> controllers/fsl/ifc.txt
> > b/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
> > > index 89427b0..824a2ca 100644
> > > --- a/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
> > > +++ b/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
> > > @@ -18,8 +18,10 @@ Properties:
> > >                interrupt (NAND_EVTER_STAT).  If there is only one,
> > >                that interrupt reports both types of event.
> > >
> > > -- little-endian : If this property is absent, the big-endian mode will
> > > -                  be in use as default for registers.
> > > +- little-endian or big-endian : It represents how IFC registers to be accessed.
> > > +			It also represents connection between controller and
> > > +			NOR flash. If this property is absent, the big-endian
> > > +			mode will be in use as default.
> >
> > My question on the prior version remains. I think if you need to handle
> > more than just register endianness, that should be done with the
> > compatible string.
> >
> 
> I may not able to use compatible string as this information will also be used it
> drivers/mtd/maps/physmap_of_core.c other than drivers/memory/fsl_ifc.c.
> I am trying to avoid controller specific details in generic file.
> 
> This is the reason endianness property is being used.
> 

Please let me know if I am not able to address your review comment

--prabhakar
