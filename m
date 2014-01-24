From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 24 Jan 2014 23:32:46 +0800
Subject: [PATCH] ARM-i.MX6Q-dts : Added USB_OTG Support
In-Reply-To: <20140124115005.GG814@e106331-lin.cambridge.arm.com>
References: <1390555724-9779-1-git-send-email-ashutosh.s@phytec.in>
 <20140124115005.GG814@e106331-lin.cambridge.arm.com>
Message-ID: <20140124153244.GB2780@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 24, 2014 at 11:50:05AM +0000, Mark Rutland wrote:
> > @@ -18,6 +18,19 @@
> >  	memory {
> >  		reg = <0x10000000 0x80000000>;
> >  	};
> > +
> > +	regulators {
> > +		compatible = "simple-bus";
> 
> This is _not_ a simple bus. It doesn't have the required ranges
> property.

Maybe the real question is that if the required ranges property is
missing, why kernel still accepts it as a simple bus and populate the
devices under it?

> 
> Why do these need to be in a regulators container node? We don't group
> dma controllers under a dmas node, or uarts under a uarts node.

Grouping fixed clocks under 'clocks' and fixed regulators under
'regulators' is a common pattern which can be found on most of the ARM
dts files.

Shawn

> 
> > +
> > +		reg_usb_otg_vbus: usb_otg_vbus {
> > +			compatible = "regulator-fixed";
> > +			regulator-name = "usb_otg_vbus";
> > +			regulator-min-microvolt = <5000000>;
> > +			regulator-max-microvolt = <5000000>;
> > +			gpio = <&gpio4 15 0>;
> > +			enable-active-low;
> > +		};
> > +	};
> >  };
> 
> Thanks,
> Mark.
