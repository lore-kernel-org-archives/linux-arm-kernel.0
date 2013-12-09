From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 9 Dec 2013 17:12:57 +0800
Subject: [PATCH v5 12/15] usb: phy: Add set_wakeup API
In-Reply-To: <52A58252.6090502@pengutronix.de>
References: <1386570664-6713-1-git-send-email-peter.chen@freescale.com>
 <1386570664-6713-13-git-send-email-peter.chen@freescale.com>
 <52A58252.6090502@pengutronix.de>
Message-ID: <20131209091256.GC5291@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 09, 2013 at 09:41:54AM +0100, Marc Kleine-Budde wrote:
> On 12/09/2013 07:31 AM, Peter Chen wrote:
> > This API is used to set wakeup enable at PHY registers, in that
> > case, the PHY can be waken up from suspend due to external events,
> 
> I' no native speaker, but I think it's "to be woken up".

Thanks, will change.

> >  
> >  static inline int
> > +usb_phy_set_wakeup(struct usb_phy *x, bool enabled)
> > +{
> > +	if (x && x->set_wakeup)
> 
> can x be NULL?
> 

Possible, this function is PHY's API, it may be called uninitialized.

Peter

> > +		return x->set_wakeup(x, enabled);
> > +	else
> > +		return 0;
> > +}
> > +
> > +static inline int
> >  usb_phy_notify_connect(struct usb_phy *x, enum usb_device_speed speed)
> >  {
> >  	if (x && x->notify_connect)
> > 
> 
> Marc
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 



-- 

Best Regards,
Peter Chen
