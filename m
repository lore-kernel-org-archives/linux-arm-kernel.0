From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Thu, 25 Feb 2010 11:31:17 +0100
Subject: [PATCH v2] MXC: mach_armadillo5x0: Add USB Host support.
In-Reply-To: <20100225100912.GB10399@pengutronix.de>
References: <1267090904.2722.8.camel@realization>
	<20100225100912.GB10399@pengutronix.de>
Message-ID: <1267093877.2722.26.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On gio, 2010-02-25 at 11:09 +0100, Uwe Kleine-K?nig wrote:
> > +static struct mxc_usbh_platform_data usbotg_pdata = {
> > +     .init   = usbotg_init,
> > +     .portsc = MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
> > +     .flags  = MXC_EHCI_POWER_PINS_ENABLED |
> MXC_EHCI_INTERFACE_DIFF_UNI,
> > +};
> > +
> > +static struct mxc_usbh_platform_data usbh2_pdata = {
> > +     .init   = usbh2_init,
> > +     .portsc = MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
> > +     .flags  = MXC_EHCI_POWER_PINS_ENABLED |
> MXC_EHCI_INTERFACE_DIFF_UNI,
> >  };
> I didn't test, but I assume gcc issues a warning about usbotg_pdata
> and
> usbh2_pdata not being used if CONFIG_USB_ULPI!=y.
> 
> 

yes, it behave the same as pcm037 do...
(another rule added to my pocket: No warnings at all for any combination
of configs!)
Let we teach how a machine code have to be developed! :)
Stay tuned for version 3


-- 
Alberto!

        Be Persistent!
                - Greg Kroah-Hartman (FOSDEM 2010)
