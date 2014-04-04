From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 4 Apr 2014 19:23:08 +0200
Subject: [PATCH 1/2] ARM: mvebu: enable the SDHCI interface on Armada 385
In-Reply-To: <20140404181508.010a6559@skate>
References: <1396626125-8631-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1396626125-8631-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140404160013.GK2798@lunn.ch> <20140404181508.010a6559@skate>
Message-ID: <20140404172308.GL2798@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 04, 2014 at 06:15:08PM +0200, Thomas Petazzoni wrote:
> Dear Andrew Lunn,
> 
> On Fri, 4 Apr 2014 18:00:13 +0200, Andrew Lunn wrote:
> 
> > > diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> > > index a064f59..2c1ff30 100644
> > > --- a/arch/arm/boot/dts/armada-38x.dtsi
> > > +++ b/arch/arm/boot/dts/armada-38x.dtsi
> > > @@ -355,6 +355,15 @@
> > >  				clocks = <&coredivclk 0>;
> > >  				status = "disabled";
> > >  			};
> > > +
> > > +			sdhci at d8000 {
> > > +				compatible = "marvell,armada-380-sdhci";
> > > +				reg = <0xd8000 0x1000>, <0xdc000 0x100>;
> > > +				interrupts = <0 25 0x4>;
> > > +				clocks = <&gateclk 17>;
> > > +				mrvl,clk-delay-cycles = <0x1F>;
> > 
> > Hi Thomas
> > 
> > Maybe this has been discussed as part of the previous patchset. Why
> > the mrvl prefix, not marvell? marvell is in vendor-prefixes.txt, but
> > mrvl does not appear to be listed.
> 
> Because I'm not the one who introduced this part of the driver DT
> binding. It has been added two years ago by:
> 
> commit b650352dd3df36164e3427bff3f33bc06ac47642
> Author: Chris Ball <cjb@laptop.org>
> Date:   Tue Apr 10 22:34:33 2012 -0400
> 
>     mmc: sdhci-pxa: Add device tree support
>     
>     Tested on an OLPC XO-1.75.  (MMP2, sdhci-pxav3, CONFIG_MACH_MMP2_DT=y)
>     
>     Signed-off-by: Chris Ball <cjb@laptop.org>
>     Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> 
> So I'm just merely using the existing DT binding for the driver. Of
> course, since I'm introducing a new compatible string, I could also
> change the driver to support the same property prefixed by "marvell,",
> but it would also have to support the old DT property forever, so is it
> really useful?

Hi Thomas

Thanks for the explanation.

Changing it makes no sense. We should just document this other vendor
prefix in vendor-prefixes.txt

	Andrew
