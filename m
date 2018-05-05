From: anson.huang@nxp.com (Anson Huang)
Date: Sat, 5 May 2018 08:37:07 +0000
Subject: [PATCH 1/2] ARM: dts: imx6sx-sabreauto: drop 'regulators'
 container node
In-Reply-To: <20180504092937.GF3443@dragon>
References: <1525426030-17221-1-git-send-email-shawnguo@kernel.org>
 <20180504092937.GF3443@dragon>
Message-ID: <AM3PR04MB1315A172B4A1DFAA58991B8BF5850@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Anson Huang
Best Regards!


> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Friday, May 4, 2018 5:30 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Anson Huang <anson.huang@nxp.com>; Fabio Estevam
> <fabio.estevam@nxp.com>; kernel at pengutronix.de; dl-linux-imx
> <linux-imx@nxp.com>
> Subject: Re: [PATCH 1/2] ARM: dts: imx6sx-sabreauto: drop 'regulators'
> container node
> 
> Hi Anson,
> 
> I will push these two patches to imx/dt branch soon.  Please base your
> imx6sx-sabreauto dts patches on them.
 
Thanks for reminder, I already rebase it and send V6 patch series.

Anson.

> 
> Shawn
> 
> On Fri, May 04, 2018 at 05:27:09PM +0800, Shawn Guo wrote:
> > Let's drop the 'regulators' container node by giving VCC_SD3 an unique
> > name and removing 'reg' property, so that the fixed regulator can be
> > under root node directly.
> >
> > Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> > ---
> >  arch/arm/boot/dts/imx6sx-sabreauto.dts | 25 +++++++++----------------
> >  1 file changed, 9 insertions(+), 16 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > index 57d1ea0a3f8e..e5c1d6daa5e0 100644
> > --- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > +++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > @@ -18,22 +18,15 @@
> >  		reg = <0x80000000 0x80000000>;
> >  	};
> >
> > -	regulators {
> > -		compatible = "simple-bus";
> > -		#address-cells = <1>;
> > -		#size-cells = <0>;
> > -
> > -		vcc_sd3: regulator at 0 {
> > -			compatible = "regulator-fixed";
> > -			reg = <0>;
> > -			pinctrl-names = "default";
> > -			pinctrl-0 = <&pinctrl_vcc_sd3>;
> > -			regulator-name = "VCC_SD3";
> > -			regulator-min-microvolt = <3000000>;
> > -			regulator-max-microvolt = <3000000>;
> > -			gpio = <&gpio2 11 GPIO_ACTIVE_HIGH>;
> > -			enable-active-high;
> > -		};
> > +	vcc_sd3: regulator-vcc-sd3 {
> > +		compatible = "regulator-fixed";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_vcc_sd3>;
> > +		regulator-name = "VCC_SD3";
> > +		regulator-min-microvolt = <3000000>;
> > +		regulator-max-microvolt = <3000000>;
> > +		gpio = <&gpio2 11 GPIO_ACTIVE_HIGH>;
> > +		enable-active-high;
> >  	};
> >  };
> >
> > --
> > 1.9.1
> >
