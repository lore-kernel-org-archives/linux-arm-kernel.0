From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 01 Jul 2013 10:59:05 +0200
Subject: [PATCH 2/2] ARM i.MX6DL: dts: add clock and mux configuration
 for LDB
In-Reply-To: <20130701085255.GE13206@S2101-09.ap.freescale.net>
References: <1372422256-22037-1-git-send-email-p.zabel@pengutronix.de>
 <1372422256-22037-2-git-send-email-p.zabel@pengutronix.de>
 <20130701085255.GE13206@S2101-09.ap.freescale.net>
Message-ID: <1372669145.4971.22.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Am Montag, den 01.07.2013, 16:52 +0800 schrieb Shawn Guo:
> On Fri, Jun 28, 2013 at 02:24:16PM +0200, Philipp Zabel wrote:
> > i.MX6DL does not have the second IPU, but the LVDS multiplexers can connect
> > either LVDS channel of the LDB to IPU1 DI0 or IPU1 DI1.
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/imx6dl.dtsi | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
> > index 80155fde..5ec89eb 100644
> > --- a/arch/arm/boot/dts/imx6dl.dtsi
> > +++ b/arch/arm/boot/dts/imx6dl.dtsi
> > @@ -417,3 +417,20 @@
> >  		};
> >  	};
> >  };
> > +
> > +&ldb {
> > +	clocks = <&clks 33>, <&clks 34>,
> > +		 <&clks 39>, <&clks 40>,
> > +		 <&clks 135>, <&clks 136>;
> > +	clock-names = "di0_pll", "di1_pll",
> > +		      "di0_sel", "di1_sel",
> > +		      "di0", "di1";
> > +
> > +	lvds-channel at 0 {
> > +		crtcs = <&ipu1 0>, <&ipu1 1>;
> > +	};
> > +
> > +	lvds-channel at 1 {
> > +		crtcs = <&ipu1 0>, <&ipu1 1>;
> > +	};
> 
> So now we have both imx6q.dtsi and imx6dl.dtsi overwrite the "crtcs"
> defined in imx6qdl.dtsi.  Should we remove it from imx6qdl.dtsi, or
> define a sane one in imx6qdl.dtsi to save one overwrite?
> 
> Shawn

I'd rather remove it from imx6qdl.dtsi completely.

regards
Philipp
