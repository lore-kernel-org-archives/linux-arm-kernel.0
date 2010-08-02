From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 2 Aug 2010 15:12:48 +0200
Subject: [PATCH] usb gadget: don't save bind callback in struct
	usb_gadget_driver
In-Reply-To: <Pine.LNX.4.64.1008021446470.10662@ask.diku.dk>
References: <op.vgs04dub7p4s8u@pikus>
	<1280752803-11441-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<Pine.LNX.4.64.1008021446470.10662@ask.diku.dk>
Message-ID: <20100802131248.GD13900@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 02, 2010 at 02:51:36PM +0200, Julia Lawall wrote:
> > diff --git a/drivers/usb/gadget/amd5536udc.c b/drivers/usb/gadget/amd5536udc.c
> > index 731150d..c266c1e 100644
> > --- a/drivers/usb/gadget/amd5536udc.c
> > +++ b/drivers/usb/gadget/amd5536udc.c
> > @@ -1954,13 +1954,14 @@ static int setup_ep0(struct udc *dev)
> >  }
> >  
> >  /* Called by gadget driver to register itself */
> > -int usb_gadget_register_driver(struct usb_gadget_driver *driver)
> > +int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
> > +		int (*bind)(struct usb_gadget *))
> >  {
> >  	struct udc		*dev = udc;
> >  	int			retval;
> >  	u32 tmp;
> >  
> > -	if (!driver || !driver->bind || !driver->setup
> > +	if (!driver || bind || !driver->setup
> 
> I have the impression that this should be !bind rather than bind.  
ah, now I see what you meant.  Obviously you're right.  I fixed it up
locally here for now.  Greg, just tell me when/if you need a fixed
patch.

> That would be like what is done in the patch for 
> drivers/usb/gadget/fsl_udc_core.c below

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
