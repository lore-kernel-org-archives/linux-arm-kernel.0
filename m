From: mgr@pengutronix.de (Michael Grzeschik)
Date: Wed, 21 Nov 2012 20:58:11 +0100
Subject: [PATCH v3 6/7] usb: chipidea: usbmisc: add mx53 support
In-Reply-To: <50AD3974.4000608@mvista.com>
References: <1353506793-8354-1-git-send-email-m.grzeschik@pengutronix.de>
 <1353506793-8354-7-git-send-email-m.grzeschik@pengutronix.de>
 <50AD3974.4000608@mvista.com>
Message-ID: <20121121195811.GB16409@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 11:28:36PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 11/21/2012 05:06 PM, Michael Grzeschik wrote:
> 
> > This adds mx53 as the next user of the usbmisc driver and makes it
> > possible to disable the overcurrent-detection of the internal phy.
> 
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> > Changes since v2:
> > * added defines for register offsets and bitmasks
> > * fixed disable_oc option for all ports
> 
> >  drivers/usb/chipidea/usbmisc_imx.c |   51 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> 
> > diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
> > index e090e0f..b1811df 100644
> > --- a/drivers/usb/chipidea/usbmisc_imx.c
> > +++ b/drivers/usb/chipidea/usbmisc_imx.c
> > @@ -19,6 +19,13 @@
> >  
> >  #define USB_DEV_MAX 4
> >  
> > +#define MX53_USB_OTG_PHY_CTRL_0_OFFSET	0x08;
> > +#define MX53_USB_UH2_CTRL_OFFSET	0x14;
> > +#define MX53_USB_UH3_CTRL_OFFSET	0x18;
> 
>    Semicolons here? This can't be right.

You're right. Its compiling without errors, because its only used at the
end of an assignement. So this will result in two Semicolons.

I will fix that.

Thanks,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
