From: scottwood@freescale.com (Scott Wood)
Date: Tue, 15 Sep 2015 17:09:03 -0500
Subject: [PATCH] arm64: dts: fsl-ls2085a: Add serial aliases
In-Reply-To: <2766847.5egOSlNQ7I@wuerfel>
References: <20150915004827.GA19862@home.buserror.net>
 <2766847.5egOSlNQ7I@wuerfel>
Message-ID: <1442354943.2909.140.camel@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-09-15 at 08:43 +0200, Arnd Bergmann wrote:
> On Monday 14 September 2015 19:48:27 Scott Wood wrote:
> > These will allow U-Boot to set linux,stdout-path in /chosen based on
> > the active console device, which will allow devicetree-based earlycon.
> > 
> > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi 
> > b/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
> > index e281ceb..eae454e 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
> > @@ -55,6 +55,11 @@
> >         #address-cells = <2>;
> >         #size-cells = <2>;
> >  
> > +       aliases {
> > +               serial0 = &serial0;
> > +               serial1 = &serial1;
> > +       };
> > +
> 
> I normally ask people to put the aliases into the board specific dts file,
> to account for machines that do not have all the uarts, or that number them
> differently from the SoC.

OK, I'll respin on top of https://patchwork.kernel.org/patch/7120211/

> I didn't know about U-Boot setting the stdout-path property, but that's
> great, as long as U-Boot uses the same numbering of the uarts that the
> board uses. Do you know if that is normally the case?

Yes, the numbering of the serial aliases in the dts should match the 
numbering that U-Boot uses.

-Scott
