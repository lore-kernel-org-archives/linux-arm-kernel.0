From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 5 Aug 2015 09:31:17 +0200
Subject: [RFC PATCH 0/3] New Atmel PIO4 pinctrl/gpio driver
In-Reply-To: <1438355290-28255-1-git-send-email-ludovic.desroches@atmel.com>
References: <1438355290-28255-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20150805073117.GP5161@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 05:08:07PM +0200, Ludovic Desroches wrote:
> Hi,
> 
> Following our discussion, I send an RFC version of my driver. RFC because it is
> not totally achieved, some cleanup and feature addition is needed.
> 
> At least, we could discuss about the 'core' part. I have used the pinmux
> property as Mediatek driver. Patch 3 is the internal dt files we are using.

As you can imagine I am fine with the binding, so I can add my acked-by
once you send a non-RFC version.

The only thing I never understood is what's so special about GPIOs that
they have to bypass the pinctrl framework and instead a gpio_request
magically translates a gpio into a pin. Wouldn't it make sense to at
least add the pins in their GPIO mode to
arch/arm/boot/dts/sama5d2-pinfunc.h?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
