From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 13 Jul 2017 16:57:21 +0800
Subject: [PATCH] arm64: dts: ls1012a: add USB host controller nodes
In-Reply-To: <AM3PR04MB14896986FF8C5A18C2643C29F1AC0@AM3PR04MB1489.eurprd04.prod.outlook.com>
References: <1499223243-13253-1-git-send-email-ran.wang_1@nxp.com>
 <20170713080717.GP3172@dragon>
 <AM3PR04MB14896986FF8C5A18C2643C29F1AC0@AM3PR04MB1489.eurprd04.prod.outlook.com>
Message-ID: <20170713085720.GX3172@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 08:46:50AM +0000, Ran Wang wrote:
> > > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> > > b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> > > index b497ac1..8aa2dcf 100644
> > > --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> > > @@ -411,6 +411,23 @@
> > >  				 <&clockgen 4 3>;
> > >  		};
> > >
> > > +		usb0: usb3 at 2f00000 {
> > > +			compatible = "snps,dwc3";
> > > +			reg = <0x0 0x2f00000 0x0 0x10000>;
> > > +			interrupts = <0 60 0x4>;
> > > +			dr_mode = "host";
> > > +			snps,quirk-frame-length-adjustment = <0x20>;
> > > +			snps,dis_rxdet_inp3_quirk;
> > > +		};
> > > +
> > > +		usb1: usb2 at 8600000 {
> > > +			compatible = "fsl-usb2-dr-v2.5", "fsl-usb2-dr";
> > > +			reg = <0x0 0x8600000 0x0 0x1000>;
> > > +			interrupts = <0 139 0x4>;
> > > +			dr_mode = "host";
> > > +			phy_type = "ulpi";
> > > +		};
> > 
> > Please keep the nodes sorted in unit-address.
> > 
> > Shawn
> Do you mean to move the node 'usb1: usb2 at 8600000' forward to where it's address is just before  '@8600000 '?
> I think it's reasonable to put USB controller nodes together in DTS for developer to do issue analysis.

The nodes under simple-bus are maintained in order of unit-address.
Please respect that.

usb2 at 8600000 should go after sata at 3200000 with the current nodes.

Shawn

> > > +
> > >  		sata: sata at 3200000 {
> > >  			compatible = "fsl,ls1012a-ahci", "fsl,ls1043a-ahci";
> > >  			reg = <0x0 0x3200000 0x0 0x10000>,
> > > --
> > > 2.1.0.27.g96db324
> > >
