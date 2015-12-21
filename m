From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 21 Dec 2015 14:12:31 +0800
Subject: [PATCH V3] ARM: dts: imx6q-icore-rqs: Add Engicam IMX6 Q7
 initial support
In-Reply-To: <20151216181159.GC20121@panicking>
References: <1447673895.3144.16.camel@pengutronix.de>
 <20151116114127.GB10464@panicking>
 <1447674695.3144.21.camel@pengutronix.de>
 <20151116115421.GC10464@panicking> <20151116172318.GA513@panicking>
 <1447752697.3144.47.camel@pengutronix.de>
 <20151118151030.GA11558@panicking> <20151211083512.GB11252@tiger>
 <20151214084456.GA4305@panicking>
 <20151216181159.GC20121@panicking>
Message-ID: <20151221061231.GA4703@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 07:12:05PM +0100, Michael Trimarchi wrote:
> Hi
> 
> I have address most of the changes but I have problem when I remove
> the group of pinctrl as you suggest
...
> > > > +&iomuxc {
> > > 
> > > Suggest move iomuxc node to the bottom to make the file a bit easier to
> > > read.
> > > 
> > 
> > Ok
> > 
> > 
> > > > +	imx6qdl-icore-rqs {
> > > > +
> > > 
> > > With commit 5fcdf6a7ed95 (pinctrl: imx: Allow parsing DT without function
> > > nodes) in place, we can now save this container.
> > > 
> 
> If I save this I can not register usb. Group is not found
> 
> [    2.768476] imx6q-pinctrl 20e0000.iomuxc: unable to find group for node usdhc1grp-1
> [    2.768844] imx6q-pinctrl 20e0000.iomuxc: unable to find group for node usdhc1grp-1
> [    2.768932] sdhci-esdhc-imx: probe of 2190000.usdhc failed with error -22
> [    2.768994] imx6q-pinctrl 20e0000.iomuxc: unable to find group for node usdhc3grp-2
> [    2.769240] imx6q-pinctrl 20e0000.iomuxc: unable to find group for node usdhc3grp-2
> [    2.769322] sdhci-esdhc-imx: probe of 2198000.usdhc failed with error -22
> [    2.769381] imx6q-pinctrl 20e0000.iomuxc: unable to find group for node usdhc4grp-1
> [    2.769621] imx6q-pinctrl 20e0000.iomuxc: unable to find group for node usdhc4grp-1
> [    2.769701] sdhci-esdhc-imx: probe of 219c000.usdhc failed with error -22

I'm not sure if you got my comment correct, but what I meant is
something like below.

&iomuxc {
       pinctrl_audmux_4: audmux-4 {
	       fsl,pins = <
		       MX6QDL_PAD_DISP0_DAT20__AUD4_TXC  0x130b0
		       MX6QDL_PAD_DISP0_DAT21__AUD4_TXD  0x110b0
		       MX6QDL_PAD_DISP0_DAT22__AUD4_TXFS 0x130b0
		       MX6QDL_PAD_DISP0_DAT23__AUD4_RXD  0x130b0
	       >;
       };

       pinctrl_enet_3: enetgrp-3 {
	       fsl,pins = <
		       MX6QDL_PAD_ENET_MDIO__ENET_MDIO       0x1b0b0
		       MX6QDL_PAD_ENET_MDC__ENET_MDC         0x1b0b0
		       MX6QDL_PAD_RGMII_TXC__RGMII_TXC       0x1b0b0
		       MX6QDL_PAD_RGMII_TD0__RGMII_TD0       0x1b0b0
		       MX6QDL_PAD_RGMII_TD1__RGMII_TD1       0x1b0b0
		       MX6QDL_PAD_RGMII_TD2__RGMII_TD2       0x1b0b0
		       MX6QDL_PAD_RGMII_TD3__RGMII_TD3       0x1b0b0
		       MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x1b0b0
		       MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK  0x1b0b0
		       MX6QDL_PAD_RGMII_RXC__RGMII_RXC       0x1b0b0
		       MX6QDL_PAD_RGMII_RD0__RGMII_RD0       0x1b0b0
		       MX6QDL_PAD_RGMII_RD1__RGMII_RD1       0x1b0b0
		       MX6QDL_PAD_RGMII_RD2__RGMII_RD2       0x1b0b0
		       MX6QDL_PAD_RGMII_RD3__RGMII_RD3       0x1b0b0
		       MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
		       MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN     0x1b0b0
	       >;
       };

       ......
};

Is this what you did?

Shawn
