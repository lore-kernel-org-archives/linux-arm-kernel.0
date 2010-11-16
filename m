From: gregkh@suse.de (Greg KH)
Date: Tue, 16 Nov 2010 06:09:47 -0800
Subject: [PATCH TRIVIAL] AT91: usb: fix typo in atmel_usba_udc driver
In-Reply-To: <alpine.LNX.2.00.1011161149460.7420@pobox.suse.cz>
References: <1289902493-1821-1-git-send-email-josh.wu@atmel.com>
	<alpine.LNX.2.00.1011161149460.7420@pobox.suse.cz>
Message-ID: <20101116140947.GA15097@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 16, 2010 at 11:51:32AM +0100, Jiri Kosina wrote:
> On Tue, 16 Nov 2010, Josh Wu wrote:
> 
> > Signed-off-by: Josh Wu <josh.wu@atmel.com>
> > ---
> > fix against 2.6.37-rc1
> > 
> >  drivers/usb/gadget/atmel_usba_udc.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
> > index b5e20e8..717ff65 100644
> > --- a/drivers/usb/gadget/atmel_usba_udc.c
> > +++ b/drivers/usb/gadget/atmel_usba_udc.c
> > @@ -2017,7 +2017,7 @@ static int __init usba_udc_probe(struct platform_device *pdev)
> >  			}
> >  		} else {
> >  			/* gpio_request fail so use -EINVAL for gpio_is_valid */
> > -			ubc->vbus_pin = -EINVAL;
> > +			udc->vbus_pin = -EINVAL;
> >  		}
> >  	}
> >  
> 
> As this is a compile fix (for bug introduced by 969affff547027), I am 
> adding Greg and linux-usb@ to CC. I usually don't push trivial changes 
> more than once per release, but this needs to go in faster.
> 
> Greg, could you please take it?

Yes, I will take it.

thanks,

greg k-h
