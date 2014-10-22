From: nm@ti.com (Nishanth Menon)
Date: Wed, 22 Oct 2014 07:24:37 -0500
Subject: [PATCH] tty: serial: omap: increase max consoles to 10
In-Reply-To: <544764D8.8050804@linutronix.de>
References: <1413908616-843-1-git-send-email-nm@ti.com>
 <544764D8.8050804@linutronix.de>
Message-ID: <20141022122437.GA9548@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:03-20141022, Sebastian Andrzej Siewior wrote:
> On 10/21/2014 06:23 PM, Nishanth Menon wrote:
> > 
> > The final solution is to transition off to use 8250 driver and no
> > dependency on console structures and move away from omap-serial driver,
> > hence no major cleanups are done for this driver.
> 
> So the shiny new driver works for you, is this what you are saying?

We have to complete our transition over to the new driver to see if we
have any behavior change. We will eventually get there.

> 
> > diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> > index 18c30ca..4f9cbb6 100644
> > --- a/drivers/tty/serial/omap-serial.c
> > +++ b/drivers/tty/serial/omap-serial.c
> > @@ -46,7 +46,7 @@
> >  
> >  #include <dt-bindings/gpio/gpio.h>
> >  
> > -#define OMAP_MAX_HSUART_PORTS	6
> > +#define OMAP_MAX_HSUART_PORTS	10
> >  
> >  #define UART_BUILD_REVISION(x, y)	(((x) << 8) | (y))
> 
> Please also add a check in the probe code that "up->port.line" does not
> exceed OMAP_MAX_HSUART_PORTS again. So we leave the probe function with
> an error code instead.

Thanks. yeah - that is a pretty good idea. Will do the same for v2.

-- 
Regards,
Nishanth Menon
