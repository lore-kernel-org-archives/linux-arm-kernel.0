From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 17 Jun 2015 09:56:47 +0200
Subject: [PATCH 5/5] ARM64: MediaTek MT8173: Add SCPSYS device node
In-Reply-To: <7hlhfjy0tq.fsf@deeprootsystems.com>
References: <1433839623-10804-1-git-send-email-s.hauer@pengutronix.de>
 <1433839623-10804-6-git-send-email-s.hauer@pengutronix.de>
 <7hlhfjy0tq.fsf@deeprootsystems.com>
Message-ID: <20150617075647.GG6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 11:17:53AM -0700, Kevin Hilman wrote:
> Sascha Hauer <s.hauer@pengutronix.de> writes:
> 
> > This adds the SCPSYS device node to the MT8173 dtsi file.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > index 924fdb6..12430f0 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > @@ -125,6 +125,16 @@
> >  						<GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
> >  		};
> >  
> > +		scpsys: scpsys at 10006000 {
> > +			compatible = "mediatek,mt8173-scpsys";
> > +			#power-domain-cells = <1>;
> > +			reg = <0 0x10006000 0 0x1000>;
> > +			clocks = <&clk26m>,
> > +				 <&topckgen CLK_TOP_MM_SEL>;
> 
> Neither your binding doc (nor the generic one) mentions these clock
> properties or what they are used for.  They appear to define a clock
> that must be enabled in order to for the power domain to be on.

Ok, will add documentation for this.

> 
> Also the order here seems rather important and probably needs
> documenting in the binding (e.g. the clk_id order is hard-coded in the
> driver.)

The order is not important, the clock-names property defines which clock
is which.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
