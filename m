From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 11 Mar 2013 10:24:19 +0100
Subject: [PATCH 3/3] can: Kconfig: CAN_AT91 depends on ARCH_AT91
In-Reply-To: <513A2396.4080508@pengutronix.de>
References: <1362763842-14924-1-git-send-email-ludovic.desroches@atmel.com>
 <1362763842-14924-4-git-send-email-ludovic.desroches@atmel.com>
 <513A2396.4080508@pengutronix.de>
Message-ID: <20130311092419.GB2572@ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 08, 2013 at 06:44:54PM +0100, Marc Kleine-Budde wrote:
> On 03/08/2013 06:30 PM, ludovic.desroches at atmel.com wrote:
> > From: Ludovic Desroches <ludovic.desroches@atmel.com>
> > 
> > SAMA5D3 devices also embed CAN feature. Moreover if we want to produce a single
> > kernel image (at least for Atmel devices) it is not useful to be too
> > restrictive.
> 
> If it compiles on other ARMs aswell we can make it depend on ARCH_ARM.
> 

I was thinking about it but I am wondering if it makes sense. Should we have a
non atmel device with atmel can?

I have no position about this point, if you think it's better to make it depending onto ARCH_ARM, I'll change it if there is no compilation issue.

Regards

Ludovic

> Marc
> > 
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > ---
> >  drivers/net/can/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> > index 9862b2e..27311c3 100644
> > --- a/drivers/net/can/Kconfig
> > +++ b/drivers/net/can/Kconfig
> > @@ -65,7 +65,7 @@ config CAN_LEDS
> >  
> >  config CAN_AT91
> >  	tristate "Atmel AT91 onchip CAN controller"
> > -	depends on ARCH_AT91SAM9263 || ARCH_AT91SAM9X5
> > +	depends on ARCH_AT91
> >  	---help---
> >  	  This is a driver for the SoC CAN controller in Atmel's AT91SAM9263
> >  	  and AT91SAM9X5 processors.
> > 
> 
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 
