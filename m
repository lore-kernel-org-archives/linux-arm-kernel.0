From: manu@bidouilliste.com (Emmanuel Vadot)
Date: Tue, 24 Jul 2018 15:34:32 +0200
Subject: [PATCH v2 5/5] arm64: dts: allwinner: h5: Add SID for H5
In-Reply-To: <20180724130004.ynaiabshexrrbvo4@flea>
References: <20180724101522.68165-1-manu@freebsd.org>
 <20180724101522.68165-5-manu@freebsd.org>
 <20180724130004.ynaiabshexrrbvo4@flea>
Message-ID: <20180724153432.e398bddfe63e51e8dcebfc46@bidouilliste.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Jul 2018 15:00:04 +0200
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> On Tue, Jul 24, 2018 at 12:15:22PM +0200, Emmanuel Vadot wrote:
> > The SID controller on H5 look the same as the one present in the A64.
> > But in case we find some difference one day at a compatible string
> > of it's own and a fallback to the A64 one.
> > 
> > Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > index 62d646baac3c..28183bf77164 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > @@ -129,3 +129,8 @@
> >  		     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> >  	compatible = "allwinner,sun50i-h5-pinctrl";
> >  };
> > +
> > +&sid {
> > +	compatible = "allwinner,sun50i-h5-sid",
> > +		     "allwinner,sun50i-a64-sid";
> > +};
> 
> This is still a bit pointless, please remove the common node.

 You mean directly declare sid controller in the SoC dtsi and not have
a common node in sunxi-h3-h5.dtsi ?

> Maxime
> 
> -- 
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com


-- 
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
