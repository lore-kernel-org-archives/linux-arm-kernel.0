From: Peter.Chen@freescale.com (Peter Chen)
Date: Mon, 10 Mar 2014 05:50:19 +0000
Subject: [PATCH 2/9] ARM: dts: i.MX51: Add a second usbphy.
In-Reply-To: <1394427060.539541345@f354.i.mail.ru>
References: <1394211863-7569-1-git-send-email-denis@eukrea.com>
 <1394211863-7569-2-git-send-email-denis@eukrea.com>
 <20140310005159.GB2727@shlinux1.ap.freescale.net>
 <1394427060.539541345@f354.i.mail.ru>
Message-ID: <c6475b21bb0d4252aded9e7a42f0d90c@BL2PR03MB226.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> > >
> > > diff --git a/arch/arm/boot/dts/imx51.dtsi
> > > b/arch/arm/boot/dts/imx51.dtsi index e508e6f..917b6ed 100644
> > > --- a/arch/arm/boot/dts/imx51.dtsi
> > > +++ b/arch/arm/boot/dts/imx51.dtsi
> > > @@ -100,6 +100,13 @@
> > >  			clocks = <&clks IMX5_CLK_USB_PHY_GATE>;
> > >  			clock-names = "main_clk";
> > >  		};
> > > +
> > > +		usbphy1: usbphy at 1 {
> > > +			compatible = "usb-nop-xceiv";
> > > +			reg = <1>;
> > > +			clocks = <&clks IMX5_CLK_USB_PHY_GATE>;
> > > +			clock-names = "main_clk";
> > > +		};
> >
> > Is this the ulpi phy for host1 controller? Why the clock is the same
> > with utmi phy clock for otg controller.
> 
> As far as I know, for i.MX51 this is as it should be.
> 

Are you sure? From clock file, they are different ccm clock gate.

> However, I doubt the usefulness of forcing "fsl,usbphy = <&usbphy1>"
> below.
> 

Yes, for ulpi phy, it should use ulpi phy driver (drivers/usb/phy/phy-ulpi.c),
not generic phy driver.

Peter
