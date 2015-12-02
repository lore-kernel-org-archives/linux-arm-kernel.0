From: marex@denx.de (Marek Vasut)
Date: Wed, 2 Dec 2015 16:41:31 +0100
Subject: [PATCH V3 2/2] ARM: dts: imx6q: add Novena board
In-Reply-To: <20151202075305.GN692@tiger>
References: <1448722024-5717-1-git-send-email-marex@denx.de>
 <1448722024-5717-2-git-send-email-marex@denx.de> <20151202075305.GN692@tiger>
Message-ID: <201512021641.31222.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, December 02, 2015 at 08:53:05 AM, Shawn Guo wrote:
> On Sat, Nov 28, 2015 at 03:47:04PM +0100, Marek Vasut wrote:
> > From: Sean Cross <xobs@kosagi.com>
> > 
> > Novena is an open-hardware laptop/desktop/bare board.
> > 
> > See http://www.kosagi.com/w/index.php?title=Novena_Main_Page
> > 
> > Signed-off-by: Sean Cross <xobs@kosagi.com>
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Sean Cross <xobs@kosagi.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> 
> Looks pretty good.  Some minor comments are below.  Most of them are
> format/style nits.

Thanks

> > ---
> > 
> >  arch/arm/boot/dts/Makefile         |   1 +
> >  arch/arm/boot/dts/imx6q-novena.dts | 846
> >  +++++++++++++++++++++++++++++++++++++ 2 files changed, 847
> >  insertions(+)
> >  create mode 100644 arch/arm/boot/dts/imx6q-novena.dts

[...]

> > +	reg_sata: sata-regulator {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "sata-power";
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		startup-delay-us = <10000>;
> > +		gpio = <&gpio3 30 GPIO_ACTIVE_HIGH>;
> > +		enable-active-high;
> > +	};
> > +
> > +	reg_usb_otg_vbus: usb_otg_vbus {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "usb_otg_vbus";
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		enable-active-high;
> > +	};
> 
> All these regulator nodes are named so arbitrarily.  Can we name them a
> bit consistently, something like regulator-xxx?

All of them are named like this (well, but the otg_vbus, I can fix that)

reg_something: something-regulator {}

What do you want to see here ?

[...]

> > +		assigned-clock-rates = <0 0 722534400 22579200>;
> > +	};
> > +};
> > +
> > +&iomuxc {
> 
> I suggest you put the &iomuxc node at the bottom of the file to make it
> easier to read the file.
> 
> > +	audmux {
> 
> With commit 5fcdf6a7ed95 (pinctrl: imx: Allow parsing DT without function
> nodes) in place, all these function nodes can just be saved to reduce one
> level of indentation.

OK, that's a good change.

> > +		pinctrl_audmux_novena: audmuxgrp-novena {
> > +			fsl,pins = <
> > +				MX6QDL_PAD_CSI0_DAT7__AUD3_RXD		0x130b0
> > +				MX6QDL_PAD_CSI0_DAT4__AUD3_TXC		0x130b0
> > +				MX6QDL_PAD_CSI0_DAT5__AUD3_TXD		0x110b0
> > +				MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS		
0x130b0
> > +			>;
> > +		};
> > +	};

[...]
