From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 9 May 2014 08:11:58 +0200
Subject: [PATCH 5/6] ARM: dts: Karo TX25: Add phy reset gpio and supply
 for FEC
In-Reply-To: <20140508142742.23e78575@ipc1.ka-ro>
References: <1399469489-22788-1-git-send-email-s.hauer@pengutronix.de>
 <1399469489-22788-6-git-send-email-s.hauer@pengutronix.de>
 <20140508142742.23e78575@ipc1.ka-ro>
Message-ID: <20140509061158.GP5858@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

On Thu, May 08, 2014 at 02:27:42PM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> Sascha Hauer wrote:
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/imx25-karo-tx25.dts | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx25-karo-tx25.dts b/arch/arm/boot/dts/imx25-karo-tx25.dts
> > index aeb1fce..ea7dddc 100644
> > --- a/arch/arm/boot/dts/imx25-karo-tx25.dts
> > +++ b/arch/arm/boot/dts/imx25-karo-tx25.dts
> > @@ -16,6 +16,21 @@
> >  	model = "Ka-Ro TX25";
> >  	compatible = "karo,imx25-tx25", "fsl,imx25";
> >  
> > +	regulators {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		reg_fec_phy: regulator at 0 {
> > +			compatible = "regulator-fixed";
> > +			reg = <0>;
> > +			regulator-name = "fec-phy";
> > +			regulator-min-microvolt = <3300000>;
> > +			regulator-max-microvolt = <3300000>;
> > +			gpio = <&gpio4 9 0>;
> >
> 			enable-active-high;
> missing here.
> 
> > +		};
> > +	};
> > +
> >  	memory {
> >  		reg = <0x80000000 0x02000000 0x90000000 0x02000000>;
> >  	};
> > @@ -77,7 +92,9 @@
> >  &fec {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&pinctrl_fec>;
> > +	phy-reset-gpios = <&gpio4 7 0>;
> >
> This must be: <&gpio3 7 0>;

Thanks for reviewing. The second round is out.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
