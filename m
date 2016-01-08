From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Fri, 8 Jan 2016 10:59:20 +0000
Subject: [PATCH v2 1/2] ARM: dts: imx6: Add support for Toradex Apalis
 iMX6Q/D SoM
In-Reply-To: <20160108084247.GB27359@ibawizard.net>
References: <1452011942-11940-1-git-send-email-marcel.ziswiler@toradex.com>
 <1452011942-11940-2-git-send-email-marcel.ziswiler@toradex.com>
 <20160106080358.GD9030@ibawizard.net>
 <1452071716.30372.61.camel@toradex.com>
 <20160108084247.GB27359@ibawizard.net>
Message-ID: <1452250758.3357.25.camel@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-01-08 at 09:42 +0100, Petr ?tetiar wrote:
> Marcel Ziswiler <marcel.ziswiler@toradex.com> [2016-01-06 09:15:18]:
> 
> > > > <&pinctrl_regulator_usbotg_pwr>;
> > > > +			regulator-name = "usb_otg_vbus";
> > > > +			regulator-min-microvolt = <5000000>;
> > > > +			regulator-max-microvolt = <5000000>;
> > > > +			gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
> > > > +			enable-active-high;
> > > > +			status = "disabled";
> > > > +		};
> > > 
> > > I'm not sure, but it seems to me, that we should move this
> > > regulator into
> > > the carrier board DTS. On our custom carrier board we've this
> > > regulator
> > > always on and we use this GPIO for heartbeat LED, so I've this in
> > > our
> > > carrier board DTS[2]:
> > 
> > Yes, you are absolutely right and e.g. on Apalis T30 [1] that is
> > exactly how
> > we did it.
> 
> And what about usdhc? It leads to the same overrides in the carrier
> board
> file:
> 
> &iomuxc {
> 	usdhc {
> 		/* GPIO4_IO20 is LVDS */
> 		pinctrl_mmc_cd: gpio_mmc_cd {
> 		};
> 
> 		/* Used as misc GPIOs */
> 		pinctrl_usdhc1: usdhc1grp {
> 		};
> 	};
> };

Yes, the same applies here.

> > > > +/* PAD Ctrl values for common settings */
> > > > +/*
> > > > + * (PAD_CTL_HYS | PAD_CTL_PUS_100K_UP | PAD_CTL_PUE |
> > > > PAD_CTL_PKE
> > > > > 
> > > > + *??PAD_CTL_SPEED_MED | PAD_CTL_DSE_40ohm)
> > > > + */
> > > > +#define PAD_CTRL_HYS_PU 0x1b0b0
> > > 
> > > This was requested to be reworked. I've simply replaced all the
> > > macros with
> > > hex values.
> > 
> > I don't think the reviewers really concluded on the action to be
> > taken
> > on here and just using hex values is probably the most stupid
> > solution.
> 
> It's simple, if you just leave it as it is, then it will never get
> merged.
> That's how kernel development works :)

Thanks but I don't think you need to explain us how any of this works
(;-p).

>  We've at least two options here:
> 
> 1. Follow the old path and just convert those macros to hex values

Yes, stupid.

> 2. Rework it - move those macros to some header file etc.

As mentioned before I don't think any agreement has been reached.

> -- ynezz


Cheers

Marcel
