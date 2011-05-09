From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 9 May 2011 10:00:02 +0200
Subject: [PATCH v3] leds: provide helper to register "leds-gpio" devices
In-Reply-To: <1304715802.30391.157.camel@rex>
References: <1302097097.22904.41.camel@rex>
	<1302554157-24145-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110412214848.GI7806@n2100.arm.linux.org.uk>
	<20110413062316.GH18850@pengutronix.de>
	<1304715802.30391.157.camel@rex>
Message-ID: <20110509080002.GA29089@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Richard,

On Fri, May 06, 2011 at 10:03:22PM +0100, Richard Purdie wrote:
> On Wed, 2011-04-13 at 08:23 +0200, Uwe Kleine-K?nig wrote:
> > On Tue, Apr 12, 2011 at 10:48:48PM +0100, Russell King - ARM Linux wrote:
> > > On Mon, Apr 11, 2011 at 10:35:57PM +0200, Uwe Kleine-K?nig wrote:
> > > > +obj-y					+= led-register.o
> > > 
> > > Why not obj-$(CONFIG_LED_REGISTER_GPIO) += led-register.o
> > > 
> > > rather than wrapping the code of led-register.c with a #ifdef for the
> > > same symbol?
> > I thought that the registration for other led-devices could go into that
> > file, too. That's why I choosed the name led-register and not
> > leds-gpio-register.c. Agreed? I don't insist on that.
> 
> I'm not sure we want/need to put other registration functions in this
> file? obj-$(CONFIG_LED_REGISTER_GPIO) probably therefore makes sense
> until some other registration need arises.
OK, then I will name the file leds-gpio-register.c. This can be renamed
to led-register.c when/if other registrations follow.

> Regardless, I'm happier with this patch than the previous ones. If you
> change it to use obj-$(CONFIG_LED_REGISTER_GPIO), 
> 
> Acked-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Who will take the patch then? Andrew? Or is there someone else I need to
Cc?

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
