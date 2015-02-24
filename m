From: stuart.yoder@freescale.com (Stuart Yoder)
Date: Tue, 24 Feb 2015 16:48:16 +0000
Subject: question about PMU interrupt in binding
In-Reply-To: <20150224161931.GT9714@leverpostej>
References: <CY1PR0301MB0748CE5D60F401F4D395E3C387160@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <20150224161931.GT9714@leverpostej>
Message-ID: <CY1PR0301MB0748CED721C84FFE226EFC1687160@CY1PR0301MB0748.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Tuesday, February 24, 2015 10:20 AM
> To: Yoder Stuart-B08248
> Cc: sboyd at codeaurora.org; Will Deacon; linux-arm-kernel at lists.infradead.org
> Subject: Re: question about PMU interrupt in binding
> 
> On Tue, Feb 24, 2015 at 03:44:27PM +0000, Stuart Yoder wrote:
> > Stephen/Will,
> >
> > Had a question about the definition of "interrupts" in the
> > PMU binding:
> >
> > > commit d84c47837d800c0db1c9f2015a1565504417f812
> > > Author: Stephen Boyd <sboyd@codeaurora.org>
> > > Date:   Fri Feb 7 21:01:24 2014 +0000
> > >
> > >     devicetree: bindings: Document Krait performance monitor units (PMU)
> > >
> > >     Document the Krait PMU compatible string.
> > >
> > >     Cc: <devicetree@vger.kernel.org>
> > >     Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > >     Signed-off-by: Will Deacon <will.deacon@arm.com>
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/pmu.txt
> b/Documentation/devicetree/bindings/arm/pmu.txt
> > > index 3e1e498..ce73144 100644
> > > --- a/Documentation/devicetree/bindings/arm/pmu.txt
> > > +++ b/Documentation/devicetree/bindings/arm/pmu.txt
> > > @@ -16,7 +16,14 @@ Required properties:
> > >         "arm,arm11mpcore-pmu"
> > >         "arm,arm1176-pmu"
> > >         "arm,arm1136-pmu"
> > > -- interrupts : 1 combined interrupt or 1 per core.
> > > +       "qcom,krait-pmu"
> > > +- interrupts : 1 combined interrupt or 1 per core. If the interrupt is a per-cpu
> > > +               interrupt (PPI) then 1 interrupt should be specified.
> >
> > If the interrupt is per-cpu do you mean 1 interrupt _per cpu_ should
> > be specified?  As written it seems to say _only_  "1 interrupt" should be
> > specificed.
> 
> The specification as written is correct.
> 
> If it's a per-cpu interrupt (i.e. a PPI), we'll recognise this fact and
> handle it appropriately in the backend, on the assumption that if the
> PMU is connected via a PPI all CPUs share this PPI.

Thanks.

Stuart
