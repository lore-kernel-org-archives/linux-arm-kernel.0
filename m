From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 May 2011 16:11:53 +0200
Subject: moving gpio driver to drivers/gpio, how to initialize?
Message-ID: <20110511141153.GJ30963@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I think we mostly agree on moving the gpio drivers from arch/arm to
drivers/gpio.  A question we have to answer is how we want to initialize
these drivers. On nomadik these are platform drivers, but on i.MX and
others platform drivers initialize too late, since the gpio functions
are already used at init_machine time. PXA uses sysdev for their gpios,
but is this the correct answer?

I have the impression that a platform device is the right answer to
this, but it would require changes in many boards.

Any thoughts?

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
