From: manu@bidouilliste.com (Emmanuel Vadot)
Date: Fri, 27 Jul 2018 13:34:39 +0200
Subject: [PATCH v2 5/5] arm64: dts: allwinner: h5: Add SID for H5
In-Reply-To: <20180727125654.ec813df71b492201aea2ca5f@bidouilliste.com>
References: <20180724101522.68165-1-manu@freebsd.org>
 <20180724101522.68165-5-manu@freebsd.org>
 <20180724130004.ynaiabshexrrbvo4@flea>
 <20180724153432.e398bddfe63e51e8dcebfc46@bidouilliste.com>
 <20180724144218.jdvgrcqkz2kmohqx@flea>
 <20180724165501.d8f01bf20c7cc43e7ed7fc62@bidouilliste.com>
 <20180726115409.7hqtvx4rdqcqdjrq@flea>
 <20180727125654.ec813df71b492201aea2ca5f@bidouilliste.com>
Message-ID: <20180727133439.2f54a1a06d7a80560027cda3@bidouilliste.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Jul 2018 12:56:54 +0200
Emmanuel Vadot <manu@bidouilliste.com> wrote:

> On Thu, 26 Jul 2018 13:54:09 +0200
> Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> 
> > On Tue, Jul 24, 2018 at 04:55:01PM +0200, Emmanuel Vadot wrote:
> > > On Tue, 24 Jul 2018 16:42:18 +0200
> > > Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > 
> > > > On Tue, Jul 24, 2018 at 03:34:32PM +0200, Emmanuel Vadot wrote:
> > > > > On Tue, 24 Jul 2018 15:00:04 +0200
> > > > > Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > > 
> > > > > > On Tue, Jul 24, 2018 at 12:15:22PM +0200, Emmanuel Vadot wrote:
> > > > > > > The SID controller on H5 look the same as the one present in the A64.
> > > > > > > But in case we find some difference one day at a compatible string
> > > > > > > of it's own and a fallback to the A64 one.
> > > > > > > 
> > > > > > > Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> > > > > > > ---
> > > > > > >  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 5 +++++
> > > > > > >  1 file changed, 5 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > > > > > > index 62d646baac3c..28183bf77164 100644
> > > > > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > > > > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > > > > > > @@ -129,3 +129,8 @@
> > > > > > >  		     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> > > > > > >  	compatible = "allwinner,sun50i-h5-pinctrl";
> > > > > > >  };
> > > > > > > +
> > > > > > > +&sid {
> > > > > > > +	compatible = "allwinner,sun50i-h5-sid",
> > > > > > > +		     "allwinner,sun50i-a64-sid";
> > > > > > > +};
> > > > > > 
> > > > > > This is still a bit pointless, please remove the common node.
> > > > > 
> > > > >  You mean directly declare sid controller in the SoC dtsi and not
> > > > > have a common node in sunxi-h3-h5.dtsi ?
> > > > 
> > > > Yep
> > > 
> > >  The reason I've put it in the common file is because I'll send patches
> > > for the nvmem-cells needed for thermal, and those are common between
> > > the two. Other nvmem-cells are also common (like the chipid and
> > > probably other).
> > 
> > Then we'll see what we can have in common and what not when we'll have
> > something in common?
> 
>  Will it make more sense that I just send a new series with nvmem-cells
> now along with thermal bindings ?

 My bad, I remembered H5 thermal sensor being the same as H3 but I was
wrong.
 I'll send a v3 with your changes suggestion and we'll see later for
thermal sensor.

> > Maxime
> > 
> > -- 
> > Maxime Ripard, Bootlin (formerly Free Electrons)
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
> 
> 
> -- 
> Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
