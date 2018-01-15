From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 15 Jan 2018 16:05:07 +0800
Subject: [PATCH v2] arm64: allwinner: a64: orangepi-zero-plus2: add usb otg
In-Reply-To: <20180115080139.k2vrczo3hnvdt3df@flea.lan>
References: <1515748144-25204-1-git-send-email-jagan@amarulasolutions.com>
 <20180115080139.k2vrczo3hnvdt3df@flea.lan>
Message-ID: <8080607.cgOBd57Bn1@ice-x220i>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2018?1?15???? CST ??4:01:39?Maxime Ripard ???
> Hi,
> 
> On Fri, Jan 12, 2018 at 02:39:04PM +0530, Jagan Teki wrote:
> > Add usb otg support for orangepi-zero-plus2 board:
> > - Add usb_otg node with dr_mode as 'otg'
> > - USB0-IDDET connected to PA21
> > - VBUS connected through DCIN which always on
> > 
> > Tested mass storage function.
> > 
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v2:
> > - Change dr_mode to peripheral
> > 
> >  .../dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts    | 18
> >  ++++++++++++++++++ 1 file changed, 18 insertions(+)
> > 
> > diff --git
> > a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
> > b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts index
> > af43533..6511190 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
> > @@ -73,6 +73,10 @@
> > 
> >  	};
> >  
> >  };
> > 
> > +&ehci0 {
> > +	status = "okay";
> > +};
> > +
> > 
> >  &mmc0 {
> >  
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&mmc0_pins_a>;
> > 
> > @@ -111,6 +115,10 @@
> > 
> >  	status = "okay";
> >  
> >  };
> > 
> > +&ohci0 {
> > +	status = "okay";
> > +};
> > +
> > 
> >  &uart0 {
> >  
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&uart0_pins_a>;
> > 
> > @@ -122,3 +130,13 @@
> > 
> >  	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
> >  	status = "okay";
> >  
> >  };
> > 
> > +
> > +&usb_otg {
> > +	dr_mode = "peripheral";
> 
> If VBUS is always on, this can only operate safely in host mode, not
> peripheral.

I think this kind of device is designed to directly drain power from the host 
in peripheral mode.

> 
> Maxime
