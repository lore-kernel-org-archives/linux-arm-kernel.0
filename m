From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 6 Jan 2011 14:40:53 +0100
Subject: mxc: i2c register mapped twice?
In-Reply-To: <20110106122611.GA31718@shlinux1.ap.freescale.net>
References: <20110106122611.GA31718@shlinux1.ap.freescale.net>
Message-ID: <20110106134053.GC26617@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 06, 2011 at 08:26:12PM +0800, Richard Zhao wrote:
> Hi Sascha,
> 
> I just realized i2c registers are mapped twice. It's first static mapped at
> mx5x_io_desc and second mapped in driver.
> Drivers always feel happy to receive physical address in resource, and ioremap
> it itself. We might static map too many register regions in machine level?
> I'm sure it's not just i2c.

There are some devices which use the static mappings, like watchdog (for
reset), irq controller, gpt. Otherwise you are right. Feel free to cleanup
here if you think there are unnecessary mappings.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
