From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 9 Feb 2015 12:25:00 +0100
Subject: [PATCH 09/13] ARM: dts: mediatek: Enable clock support for
 Mediatek MT8135.
In-Reply-To: <20150209105134.GF8656@n2100.arm.linux.org.uk>
References: <1423478845-2835-1-git-send-email-s.hauer@pengutronix.de>
 <1423478845-2835-10-git-send-email-s.hauer@pengutronix.de>
 <20150209105134.GF8656@n2100.arm.linux.org.uk>
Message-ID: <20150209112500.GU12209@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 09, 2015 at 10:51:34AM +0000, Russell King - ARM Linux wrote:
> On Mon, Feb 09, 2015 at 11:47:21AM +0100, Sascha Hauer wrote:
> > From: James Liao <jamesjj.liao@mediatek.com>
> > 
> > This patch adds MT8135 clock controllers into device tree.
> > @@ -86,6 +87,18 @@
> >  			clock-frequency = <32000>;
> >  			#clock-cells = <0>;
> >  		};
> > +
> > +		clk_null: clk_null {
> > +			compatible = "fixed-clock";
> > +			#clock-cells = <0>;
> > +			clock-frequency = <0>;
> > +		};
> > +
> > +		clk26m: clk26m {
> > +			compatible = "fixed-clock";
> > +			#clock-cells = <0>;
> > +			clock-frequency = <26000000>;
> > +		};
> 
> Is this supposed to be here?

The clock support needs at least the clk26m clk. Do you think it should
be in another patch or not present at all?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
