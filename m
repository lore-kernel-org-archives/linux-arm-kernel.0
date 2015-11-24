From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 24 Nov 2015 17:19:55 +0800
Subject: [PATCH] ARM: dts: imx6q-icore-rqs: Add Engicam IMX6 Q7 initial
 support
In-Reply-To: <1447673895.3144.16.camel@pengutronix.de>
References: <1447584853-12560-1-git-send-email-michael@amarulasolutions.com>
 <1447665552.3144.6.camel@pengutronix.de>
 <20151116112931.GA10464@panicking>
 <1447673895.3144.16.camel@pengutronix.de>
Message-ID: <20151124091955.GU11999@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 12:38:15PM +0100, Lucas Stach wrote:
<snip>
> > > > +		reg_sd3_vmmc: sd3_vmmc {
> > > > +			compatible = "regulator-fixed";
> > > > +			regulator-name = "P3V3_SD3_SWITCHED";
> > > > +			regulator-min-microvolt = <3300000>;
> > > > +			regulator-max-microvolt = <3300000>;
> > > > +			gpio = <&gpio1 4 GPIO_ACTIVE_LOW>;
> > > > +			regulator-boot-on;
> > > > +			regulator-always-on;
> > > > +		};
> > > 
> > > A lot of those regulators look like they don't need to be always-on.
> > > 
> > > Also the use of a simple-bus, while giving some structure to the DT is
> > > considered bad style as it doesn't reflect any real hardware.
> > > 
> > 
> > I will check how other boards do it
> > 
> Note that there are a lot of bad examples still around. What you need to
> do is essentially just remove the additional DT level of the regulator
> bus. The regulators are board components that belong to the same level
> as the usb hub below, or the memory node above.

Will kernel populate platform_device for these fixed regulators if they
are being put directly under root node?  Kernel used to only do that for
devices under simple-bus.

Shawn
