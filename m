From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 4 Dec 2013 21:05:25 +0800
Subject: [PATCH v3 10/10] usb: chipidea: imx: Enable CI_HDRC_IMX_EHCI_QUIRK
In-Reply-To: <529EE8D6.2030600@pengutronix.de>
References: <1383616525-10769-1-git-send-email-peter.chen@freescale.com>
 <1383616525-10769-11-git-send-email-peter.chen@freescale.com>
 <529E5215.5000107@pengutronix.de>
 <F281D0F91ED19E4D8E63A7504E8A6498041427E5@039-SN2MPN1-021.039d.mgd.msft.net>
 <529EE8D6.2030600@pengutronix.de>
Message-ID: <20131204130524.GA1573@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 09:33:26AM +0100, Marc Kleine-Budde wrote:
> On 12/04/2013 02:40 AM, Peter Chen wrote:
> > There are some re-work for this serial, I will do it.
> > But I don't get your mean why it needs to squash into another patch?
> 
> Let's look at the code again:
> 
> > -	if (imx_platform_flag->flags & CI_HDRC_IMX_SUPPORT_RUNTIME_PM)
> > +	if (imx_platform_flag->flags & CI_HDRC_IMX_SUPPORT_RUNTIME_PM) {
> >  		pdata.flags |= CI_HDRC_SUPPORTS_RUNTIME_PM;
> >  		data->supports_runtime_pm = true;
> >  	}
> 
> Without that patch, the driver will not compile.
> 
> before:
> 
> if ()
> 	/* code */
> }
> 
> after:
> 
> if () {
> 	/* code */
> }
> 
> Marc
> 
> -- 

Oh, thanks. I need to sqhash [7/10] and [10/10]

-- 

Best Regards,
Peter Chen
