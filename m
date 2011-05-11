From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 11 May 2011 15:20:16 +0100
Subject: moving gpio driver to drivers/gpio, how to initialize?
In-Reply-To: <20110511141153.GJ30963@pengutronix.de>
References: <20110511141153.GJ30963@pengutronix.de>
Message-ID: <20110511142016.GG3188@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2011 at 04:11:53PM +0200, Sascha Hauer wrote:
> I think we mostly agree on moving the gpio drivers from arch/arm to
> drivers/gpio.  A question we have to answer is how we want to initialize
> these drivers. On nomadik these are platform drivers, but on i.MX and
> others platform drivers initialize too late, since the gpio functions
> are already used at init_machine time. PXA uses sysdev for their gpios,
> but is this the correct answer?

The omap gpio driver registers the platform_driver as a 
postcore_initcall so that it can use GPIO in the machine init for this 
reason.  A platform_device/driver feels like the right way to do this 
IMHO.

Jamie
