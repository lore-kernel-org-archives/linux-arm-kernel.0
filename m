From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 20 May 2011 12:02:42 +0200
Subject: [PATCH 0/4] add gpio driver gpio-mxs
In-Reply-To: <1305885089-27343-1-git-send-email-shawn.guo@linaro.org>
References: <1305885089-27343-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110520100242.GA10403@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Fri, May 20, 2011 at 05:51:25PM +0800, Shawn Guo wrote:
> The patch set is to move Freescale MXS gpio driver from mach-mxs
> into drivers/gpio.  Different from u300 gpio driver that all gpio
> ports are registered as one device, gpio-mxs expects every single
> port is a gpio device.
> 
> The first 3 patches are just to ease review and can be squashed into
> the last one.
> 
> Shawn Guo (4):
>       gpio: gpio-mxs: add file gpio-mxs.c
>       gpio: gpio-mxs: drop mach-specific accessors
>       gpio: gpio-mxs: remove gpio port definition and registration
>       gpio: gpio-mxs: add gpio driver for Freescale MXS architecture

Your series should be bisectible. So please either:

- Add the driver the way you want it (no need to modify a new file in
  four steps)
- atomically switch to the new driver
- remove old driver

or:

- work on old file until it's suitable for drivers/gpio
- move old file to drivers/gpio and adjust the makefiles in one step.


There may be different variations on this depending on the actual code,
but whatever you do, each step should be able to compile and working.


Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
