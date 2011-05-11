From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 May 2011 16:42:21 +0200
Subject: moving gpio driver to drivers/gpio, how to initialize?
In-Reply-To: <20110511142016.GG3188@pulham.picochip.com>
References: <20110511141153.GJ30963@pengutronix.de>
	<20110511142016.GG3188@pulham.picochip.com>
Message-ID: <20110511144221.GK30963@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2011 at 03:20:16PM +0100, Jamie Iles wrote:
> On Wed, May 11, 2011 at 04:11:53PM +0200, Sascha Hauer wrote:
> > I think we mostly agree on moving the gpio drivers from arch/arm to
> > drivers/gpio.  A question we have to answer is how we want to initialize
> > these drivers. On nomadik these are platform drivers, but on i.MX and
> > others platform drivers initialize too late, since the gpio functions
> > are already used at init_machine time. PXA uses sysdev for their gpios,
> > but is this the correct answer?
> 
> The omap gpio driver registers the platform_driver as a 
> postcore_initcall so that it can use GPIO in the machine init for this 
> reason.  A platform_device/driver feels like the right way to do this 
> IMHO.

Ah, I somehow missed that platform drivers can be up and running at
init_machine time. Then this is not a problem at all.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
