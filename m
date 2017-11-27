From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Nov 2017 23:14:06 +0000
Subject: [PATCH 01/13] ARM: dts: imx6qdl: SolidRun: remove redundant
 regulators node
In-Reply-To: <CAOMZO5B9GW26+3EfutnH4meUec3qq09Q6OBYHTtdvWG+DavJwg@mail.gmail.com>
References: <20171127165134.GH31757@n2100.armlinux.org.uk>
 <E1eJMdd-0002qR-Or@rmk-PC.armlinux.org.uk>
 <CAOMZO5B9GW26+3EfutnH4meUec3qq09Q6OBYHTtdvWG+DavJwg@mail.gmail.com>
Message-ID: <20171127231406.GQ31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 06:15:25PM -0200, Fabio Estevam wrote:
> On Mon, Nov 27, 2017 at 2:52 PM, Russell King
> <rmk+kernel@armlinux.org.uk> wrote:
> 
> > -               };
> > +       reg_usbh1_vbus: usb-h1-vbus {
> > +               compatible = "regulator-fixed";
> > +               enable-active-high;
> > +               gpio = <&gpio1 0 0>;
> 
> gpio = <&gpio1 0 GPIO_ACTIVE_HIGH>; would be easier to read.
> 
> > +       reg_usbotg_vbus: usb-otg-vbus {
> > +               compatible = "regulator-fixed";
> > +               enable-active-high;
> > +               gpio = <&gpio3 22 0>;
> 
> Ditto.
> 
> > +       reg_brcm: brcm-reg {
> > +               compatible = "regulator-fixed";
> > +               enable-active-high;
> > +               gpio = <&gpio3 19 0>;
> 
> Ditto.

Again, this is not new code, such a change should be a separate patch,
maybe even separate from this series.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
