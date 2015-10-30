From: stuart.yoder@freescale.com (Stuart Yoder)
Date: Fri, 30 Oct 2015 16:34:26 +0000
Subject: [PATCH v2] arm64: dts: Added syscon-reboot node for FSL's LS2085A
 SoC
In-Reply-To: <3919319.0f6zV1T7g0@wuerfel>
References: <1446066584-3738-1-git-send-email-German.Rivera@freescale.com>
 <3919319.0f6zV1T7g0@wuerfel>
Message-ID: <CY1PR0301MB07483E9D229314891961B6AD872F0@CY1PR0301MB0748.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Thursday, October 29, 2015 4:49 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Rivera Jose-B46482; robh+dt at kernel.org; mark.rutland at arm.com; devicetree at vger.kernel.org; linux-
> kernel at vger.kernel.org; Sharma Bhupesh-B45370; Li Yang-Leo-R58472; Yoder Stuart-B08248
> Subject: Re: [PATCH v2] arm64: dts: Added syscon-reboot node for FSL's LS2085A SoC
> 
> On Wednesday 28 October 2015 16:09:44 J. German Rivera wrote:
> > +       rst_ccsr: rstccsr at 1E60000 {
> > +               compatible = "syscon";
> > +               reg = <0x0 0x1E60000 0x0 0x10000>;
> > +       };
> > +
> >
> 
> What does 'rstccsr' stand for? Is this by chance a reset controller?

It is a region of some miscellaneous registers, some related to reset.
 
> If so, we probably want a real driver for it rather than just a
> syscon.

There is not other stuff in this region that to be exposed,
and so we really don't need a real driver.

My suggestion is to perhaps make that more explicit in the proposed
device tree node, by making the reg size "4" and naming it
as per the register name

       rstcr: rstcr at 1E60000 {
               compatible = "syscon";
               reg = <0x0 0x1E60000 0x0 0x4>;
       };

The intent is really just to expose a single reset register
and use syscon-reboot until PSCI is available.

Thanks,
Stuart
