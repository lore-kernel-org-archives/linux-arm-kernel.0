From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 13 Apr 2011 08:23:16 +0200
Subject: [PATCH v3] leds: provide helper to register "leds-gpio" devices
In-Reply-To: <20110412214848.GI7806@n2100.arm.linux.org.uk>
References: <1302097097.22904.41.camel@rex>
	<1302554157-24145-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110412214848.GI7806@n2100.arm.linux.org.uk>
Message-ID: <20110413062316.GH18850@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Apr 12, 2011 at 10:48:48PM +0100, Russell King - ARM Linux wrote:
> On Mon, Apr 11, 2011 at 10:35:57PM +0200, Uwe Kleine-K?nig wrote:
> > diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> > index 9bec869..e8e101e 100644
> > --- a/drivers/leds/Kconfig
> > +++ b/drivers/leds/Kconfig
> > @@ -14,6 +14,11 @@ config LEDS_CLASS
> >  	  This option enables the led sysfs class in /sys/class/leds.  You'll
> >  	  need this to do anything useful with LEDs.  If unsure, say N.
> >  
> > +config LED_REGISTER_GPIO
> > +	bool
> > +	help
> > +	  This option provides the function gpio_led_register_device.
> > +
> >  if NEW_LEDS
> >  
> >  comment "LED drivers"
> > diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> > index 39c80fc..ca428bd 100644
> > --- a/drivers/leds/Makefile
> > +++ b/drivers/leds/Makefile
> > @@ -3,6 +3,7 @@
> >  obj-$(CONFIG_NEW_LEDS)			+= led-core.o
> >  obj-$(CONFIG_LEDS_CLASS)		+= led-class.o
> >  obj-$(CONFIG_LEDS_TRIGGERS)		+= led-triggers.o
> > +obj-y					+= led-register.o
> 
> Why not obj-$(CONFIG_LED_REGISTER_GPIO) += led-register.o
> 
> rather than wrapping the code of led-register.c with a #ifdef for the
> same symbol?
I thought that the registration for other led-devices could go into that
file, too. That's why I choosed the name led-register and not
leds-gpio-register.c. Agreed? I don't insist on that.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
