From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 13 May 2014 07:48:01 +0200
Subject: i.MX6 USB OTG support is broken on linux-next
In-Reply-To: <0ca71a532bd14b6d81e6799969f8f580@BL2PR03MB226.namprd03.prod.outlook.com>
References: <20140509130046.GP2794@dragon>
 <20140510111003.GA1593@shlinux1.ap.freescale.net>
 <20140510131815.GT2794@dragon>
 <20140510135737.GA1878@shlinux1.ap.freescale.net>
 <20140512054549.GC5858@pengutronix.de>
 <0ca71a532bd14b6d81e6799969f8f580@BL2PR03MB226.namprd03.prod.outlook.com>
Message-ID: <20140513054801.GI5858@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 12:33:30AM +0000, Peter Chen wrote:
>  
> > 
> > On Sat, May 10, 2014 at 09:57:39PM +0800, Li Jun wrote:
> > > On Sat, May 10, 2014 at 09:18:36PM +0800, Shawn Guo wrote:
> > > > + Robin and David,
> > > >
> > > > diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
> > > > index cb8e991..9081757 100644
> > > > --- a/drivers/usb/core/Kconfig
> > > > +++ b/drivers/usb/core/Kconfig
> > > > @@ -65,7 +65,6 @@ config USB_OTG
> > > >  config USB_OTG_WHITELIST
> > > >         bool "Rely on OTG Targeted Peripherals List"
> > > >         depends on USB_OTG || EXPERT
> > > > -       default y if USB_OTG
> > > >         help
> > > >           If you say Y here, the "otg_whitelist.h" file will be used
> > as a
> > > >           product whitelist, so USB peripherals not listed there will
> > be
> > > >
> > > > Shawn
> > > As Peter suggested, do not enable OTG_FSM in defconfig since there are
> > very few
> > > HNP&SRP capable device in market. With OTG_FSM enabled, even
> > USB_OTG_WHITELIST
> > > is not selected, the OTG port still can't work the same as before if
> > you connect
> > > a normal usb device to it.
> > 
> > If a device is not HNP/SRP capable then it should not be used on this
> > device. If we can't detect this during runtime then there should be some
> > devicetree property for that. Making such decisions during compile time
> > is not an option in the days of multimachine kernels.
> > 
> > Sascha
> > 
> 
> I don't think OTG option should be set for multi-machine kernel configurations,
> the otg device will not be server, and it is a customized device (eg, the Targeted
> Peripherals List need to be updated when it goes to be product).

I want to enable OTG support when one of the devices I want to run the
kernel on is OTG capable. OTG is just a driver, there's no sane reason
to break stuff just because it's enabled in the config. We're long past
the point of single machine kernels.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
