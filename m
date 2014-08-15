From: stuart.yoder@freescale.com (Stuart Yoder)
Date: Fri, 15 Aug 2014 13:12:03 +0000
Subject: [PATCH 3/6] Documentation: DT: Add entry for FSL Management
 Complex
In-Reply-To: <20140815110020.GC15621@leverpostej>
References: <1408096156-29772-1-git-send-email-bhupesh.sharma@freescale.com>
 <1408096156-29772-4-git-send-email-bhupesh.sharma@freescale.com>
 <20140815110020.GC15621@leverpostej>
Message-ID: <fa6ec1987fca45559c58778f664acfa5@BY2PR0301MB0743.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Friday, August 15, 2014 6:00 AM
> To: Sharma Bhupesh-B45370
> Cc: devicetree at vger.kernel.org; Catalin Marinas; arnd at arndb.de; Rivera Jose-
> B46482; Will Deacon; Yoder Stuart-B08248; grant.likely at secretlab.ca; Basu
> Arnab-B45036; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 3/6] Documentation: DT: Add entry for FSL Management
> Complex
> 
> [devicetree-discuss is no more, fixing up to devicetree at vger.kernel.org]
> 
> Hi,
> 
> On Fri, Aug 15, 2014 at 10:49:12AM +0100, Bhupesh Sharma wrote:
> > This patch adds a devicetree binding documentation for FSL's
> > Management Complex.
> >
> > Management Complex is a hardware resource manager that manages
> > specialized hardware objects used in network-oriented packet
> > processing applications
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> > Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> > Signed-off-by: J. German Rivera <German.Rivera@freescale.com>
> > ---
> >  .../devicetree/bindings/misc/fsl,qoriq-mc.txt      |   40
> ++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> >
> > diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> > new file mode 100644
> > index 0000000..608529e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> > @@ -0,0 +1,40 @@
> > +* Freescale Management Complex
> > +
> > +The Freescale Management Complex (fsl-mc) is a hardware resource
> > +manager that manages specialized hardware objects used in
> > +network-oriented packet processing applications.  After the fsl-mc
> > +block is enabled, pools of hardware resources are available, such as
> > +queues, buffer pools, I/O interfaces.  These resources are building
> > +blocks that can be used to create functional hardware objects/devices
> > +such as network interfaces, crypto accelerator instances, L2 switches,
> > +etc.
> > +
> > +Required properties:
> > +
> > +    - compatible
> > +        Value type: <string>
> > +        Definition: Must be "fsl,qoriq-mc".  A Freescale Management Complex
> > +                    compatible with this binding must have Block Revision
> > +                    Registers BRR1 and BRR2 at offset 0x0BF8 and 0x0BFC in
> > +                    the MC control register region.
> > +
> > +    - reg
> > +        Value type: <prop-encoded-array>
> > +        Definition: A standard property.  Specifies one or two regions
> > +                    defining the MC's registers:
> > +
> > +                       -the first region is the command portal for the
> > +                        this machine and must always be present
> > +
> > +                       -the second region is the MC control registers. This
> > +                        region may not be present in some scenarios, such
> > +                        as in the device tree presented to a virtual
> machine.
> 
> This looks extremely simple. Is this unit self-contained or does it
> relate to other blocks which will be described separately?

The block is self-contained.  It's a complicated block, but all interactions
with happen through the command interface (1st reg region).

[The MC can do DMA and thus will relate to the SMMU, but there is some
present churn around the SMMU and we'll define the needed properties
(#stream-id-cells or whatever) when that is clear.]

Stuart
