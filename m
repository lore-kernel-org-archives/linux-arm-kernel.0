From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 10 Mar 2014 08:40:17 +0800
Subject: [PATCH 1/9] usb: chipidea: usbmisc: Add USB Host support for
 i.MX25/i.MX35 CPUs
In-Reply-To: <1394256735.984728060@f310.i.mail.ru>
References: <1394211863-7569-1-git-send-email-denis@eukrea.com>
 <1394256735.984728060@f310.i.mail.ru>
Message-ID: <20140310004016.GA2727@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 08, 2014 at 09:32:15AM +0400, Alexander Shiyan wrote:
> ???????,  7 ????? 2014, 18:04 +01:00 ?? Denis Carikli <denis@eukrea.com>:
> > Signed-off-by: Denis Carikli <denis@eukrea.com>
> > ---
> >  drivers/usb/chipidea/usbmisc_imx.c |   59 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> > 
> > diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
> > index cd061ab..d956ad0 100644
> > --- a/drivers/usb/chipidea/usbmisc_imx.c
> > +++ b/drivers/usb/chipidea/usbmisc_imx.c
> ...
> > +		val = readl(usbmisc->base);
> > +		val &= ~(MX25_OTG_SIC_MASK | MX25_OTG_PP_BIT);
> > +		val |= (MXC_EHCI_INTERFACE_DIFF_UNI & MXC_EHCI_INTERFACE_MASK) << MX25_OTG_SIC_SHIFT;
> > +		val |= (MX25_OTG_PM_BIT | MX25_OTG_OCPOL_BIT);
> > +		writel(val, usbmisc->base);
> 
> At the moment, we only enable/disable interface and manage overcurrent option
> in the usbmisc driver.
> Is it worth it to handle type of interface here?
> 

All usb related things which are not included at chipidea core can be in
usbmisc driver.

-- 

Best Regards,
Peter Chen
