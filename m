From: Peter.Chen@freescale.com (Peter Chen)
Date: Mon, 10 Mar 2014 06:04:09 +0000
Subject: [PATCH 2/9] ARM: dts: i.MX51: Add a second usbphy.
In-Reply-To: <1394431126.727643973@f362.i.mail.ru>
References: <1394211863-7569-1-git-send-email-denis@eukrea.com>
 <1394427060.539541345@f354.i.mail.ru>
 <c6475b21bb0d4252aded9e7a42f0d90c@BL2PR03MB226.namprd03.prod.outlook.com>
 <1394431126.727643973@f362.i.mail.ru>
Message-ID: <75c56321738944039b45c068f7c68693@BL2PR03MB226.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> >
> > > > >
> > > > > diff --git a/arch/arm/boot/dts/imx51.dtsi
> > > > > b/arch/arm/boot/dts/imx51.dtsi index e508e6f..917b6ed 100644
> > > > > --- a/arch/arm/boot/dts/imx51.dtsi
> > > > > +++ b/arch/arm/boot/dts/imx51.dtsi
> > > > > @@ -100,6 +100,13 @@
> > > > >  			clocks = <&clks IMX5_CLK_USB_PHY_GATE>;
> > > > >  			clock-names = "main_clk";
> > > > >  		};
> > > > > +
> > > > > +		usbphy1: usbphy at 1 {
> > > > > +			compatible = "usb-nop-xceiv";
> > > > > +			reg = <1>;
> > > > > +			clocks = <&clks IMX5_CLK_USB_PHY_GATE>;
> > > > > +			clock-names = "main_clk";
> > > > > +		};
> > > >
> > > > Is this the ulpi phy for host1 controller? Why the clock is the
> > > > same with utmi phy clock for otg controller.
> > >
> > > As far as I know, for i.MX51 this is as it should be.
> > >
> >
> > Are you sure? From clock file, they are different ccm clock gate.
> 
> clk-imx51-imx53.c ? I think you confuse with i.MX50/53.
> 

Yes

341         clk[IMX5_CLK_USB_PHY1_GATE]     = imx_clk_gate2("usb_phy1_gate", "usb_phy_sel", MXC_CCM_CCGR4, 10);
342         clk[IMX5_CLK_USB_PHY2_GATE]     = imx_clk_gate2("usb_phy2_gate", "usb_phy_sel", MXC_CCM_CCGR4, 12);
