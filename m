From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 25 Sep 2015 10:17:58 -0700
Subject: [PATCH v5 3/7] ARM: dts: imx: imx7d-sbd add iomuxc-lpsr hoggrp-2
 pads
In-Reply-To: <20150925104922.GK11805@pengutronix.de>
References: <1443128043-21063-1-git-send-email-aalonso@freescale.com>
 <1443128043-21063-3-git-send-email-aalonso@freescale.com>
 <20150925104922.GK11805@pengutronix.de>
Message-ID: <20150925171758.GW3529@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 25, 2015 at 12:49:22PM +0200, Markus Pargmann wrote:
> On Thu, Sep 24, 2015 at 03:53:59PM -0500, Adrian Alonso wrote:
> > Add imx7d-sdb iomuxc-lpsr hoggrp-2 default pads settings
> > 
> > Signed-off-by: Adrian Alonso <aalonso@freescale.com>
> > ---
> > Changes for V2: Resend
> > Changes for V3: Resend
> > Changes for V4: Resend
> > Changes for V5: Resend
> > 
> >  arch/arm/boot/dts/imx7d-sdb.dts | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
> > index 8059458..c8a178c 100644
> > --- a/arch/arm/boot/dts/imx7d-sdb.dts
> > +++ b/arch/arm/boot/dts/imx7d-sdb.dts
> > @@ -419,3 +419,18 @@
> >  
> >  	};
> >  };
> > +
> > +&iomuxc_lpsr {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_hog_2>;
> > +
> > +	imx7d-sdb {
> > +		pinctrl_hog_2: hoggrp-2 {
> > +			fsl,pins = <
> > +				MX7D_PAD_GPIO1_IO05__GPIO1_IO5    0x14
> > +				MX7D_PAD_GPIO1_IO07__GPIO1_IO7    0x59
> > +				MX7D_PAD_GPIO1_IO00__WDOD1_WDOG_B 0x74
> 
> In my opinion this should still be in the pincontrol for the watchdog
> instead of hogging. Also it is not obvious what the GPIOs are for.

+1

Shawn
