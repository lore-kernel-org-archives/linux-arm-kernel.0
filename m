From: mgr@pengutronix.de (Michael Grzeschik)
Date: Sun, 8 Mar 2015 17:13:58 +0100
Subject: [PATCH 1/2] ARM: dts: imx6: factor out pinmux for edm1 module
In-Reply-To: <20150220185351.GN15673@pengutronix.de>
References: <1424457195-8796-1-git-send-email-m.grzeschik@pengutronix.de>
 <20150220185351.GN15673@pengutronix.de>
Message-ID: <20150308161358.GB29524@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 07:53:51PM +0100, Robert Schwebel wrote:
> Adding Fabio to Cc, who brought Wandboard into the kernel. Could you
> give Michael's patch a try? We don't have a Wandboard here for testing,
> so this should get a Tested-By from you (or somebody else with hardware)
> before applying.
> 
> rsc
> 
> On Fri, Feb 20, 2015 at 07:33:14PM +0100, Michael Grzeschik wrote:
> > Thw Wandboard is using the EDM1-CF-IMX6 module which is
> > defined under the edm standard.
> > 
> > http://www.edm-standard.org/
> > 
> > As this module is used on more boards this patch moves the default
> > pinmux settings into the special file imx6qdl-edm1.dtsi.
> > 
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/imx6qdl-edm1.dtsi      | 231 +++++++++++++++++++++++++++++++
> >  arch/arm/boot/dts/imx6qdl-wandboard.dtsi |  99 +------------
> >  2 files changed, 233 insertions(+), 97 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/imx6qdl-edm1.dtsi
> > 
> > diff --git a/arch/arm/boot/dts/imx6qdl-edm1.dtsi b/arch/arm/boot/dts/imx6qdl-edm1.dtsi
> > new file mode 100644
> > index 0000000..b42605b
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx6qdl-edm1.dtsi
> > @@ -0,0 +1,231 @@
> > +&iomuxc {
> > +	pinctrl-names = "default";
> > +
> > +	imx6qdl-edm1 {
> > +
> > +		pinctrl_audmux: audmuxgrp {
> > +			fsl,pins = <
> > +				MX6QDL_PAD_CSI0_DAT7__AUD3_RXD		0x130b0
> > +				MX6QDL_PAD_CSI0_DAT4__AUD3_TXC		0x130b0
> > +				MX6QDL_PAD_CSI0_DAT5__AUD3_TXD		0x110b0
> > +				MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS		0x130b0
> > +				MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x130b0
> > +			>;
> > +		};
> > +
> > +		pinctrl_enet: enetgrp {
> > +			fsl,pins = <
> > +				MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
> > +				MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
> > +				MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x1b0b0
> > +				MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b0b0
> > +				MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b0b0
> > +				MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b0b0
> > +				MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x1b0b0
> > +				MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b0b0
> > +				MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b0b0
> > +				MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b0b0
> > +				MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x1b0b0
> > +				MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x1b0b0
> > +				MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b0b0
> > +				MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b0b0
> > +				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b0b0
> > +				MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x4001b0a8
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

                                This seems somehow board revision
                                specific. It breaks the Toucan fec to
                                work. I will send v2 with this moved to
                                the hog pins of the wandboard revisions.

Thanks,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
