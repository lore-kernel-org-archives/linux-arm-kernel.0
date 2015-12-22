From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 22 Dec 2015 20:24:35 +0800
Subject: [PATCH 1/2] ARM: dts: ts-4800: Add LCD support
In-Reply-To: <20151221184057.GE12696@localhost>
References: <1450458033-30471-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <20151221133519.GC18410@tiger> <20151221184057.GE12696@localhost>
Message-ID: <20151222122435.GE26290@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2015 at 01:40:59PM -0500, Damien Riegel wrote:
> > > @@ -30,6 +30,60 @@
> > >  			clock-frequency = <24576000>;
> > >  		};
> > >  	};
> > > +
> > > +	regulators {
> > > +		compatible = "simple-bus";
> > > +		#address-cells = <1>;
> > > +		#size-cells = <0>;
> > > +
> > > +		backlight_reg: regulator at 0 {
> > > +			compatible = "regulator-fixed";
> > > +			reg = <0>;
> > > +			pinctrl-names = "default";
> > > +			pinctrl-0 = <&pinctrl_enable_lcd>;
> > > +			regulator-name = "enable_lcd_reg";
> > > +			regulator-min-microvolt = <3300000>;
> > > +			regulator-max-microvolt = <3300000>;
> > > +			gpio = <&gpio4 9 GPIO_ACTIVE_HIGH>;
> > > +			enable-active-high;
> > > +		};
> > > +	};
> > 
> > DT maintainers dislike this fake simple-bus container.  Let's put the
> > regulator directly under root like below.
> > 
> >         backlight_reg: regulator-backlight {
> >                 compatible = "regulator-fixed";
> >                 pinctrl-names = "default";
> >                 pinctrl-0 = <&pinctrl_enable_lcd>;
> >                 regulator-name = "enable_lcd_reg";
> >                 regulator-min-microvolt = <3300000>;
> >                 regulator-max-microvolt = <3300000>;
> >                 gpio = <&gpio4 9 GPIO_ACTIVE_HIGH>;
> >                 enable-active-high;
> >         };
> > 
> > I fixed it up and applied both patches.
> 
> Thank you. I am using the imx51-*.dts as examples, maybe they should be
> updated to be consistent with the newer device tree style? I'm willing
> to do that but I don't want to make changes on dts files that I can't
> test.

Leave them there for now.

> 
> Sidenote: your Signed-off-by is missing on these two patches.

Oops.  Thanks.  Fixed now.

Shawn
