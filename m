From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 2 Nov 2010 18:42:47 +0100
Subject: [patch v4 06/10] efikamx: add leds support
In-Reply-To: <20101102083858.GP31158@pengutronix.de>
References: <20101027124044.980739780@rtp-net.org>
	<20101027124347.146428989@rtp-net.org>
	<201010300954.47839.marek.vasut@gmail.com>
	<20101102083858.GP31158@pengutronix.de>
Message-ID: <20101102174247.GG6017@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 02, 2010 at 09:38:58AM +0100, Uwe Kleine-K?nig wrote:
> > >  /* Serial ports */
> > > @@ -179,6 +189,37 @@
> > >  	}
> > >  }
> > 
> > Maybe this could be modularized ?
> > 
> > #ifdef CONFIG_LEDS_GPIO
> > ... the platform_data stuff below ...
> > 
> > efikamx_register_leds()
> > {
> > 	platform_device_register();
> > }
> > #else
> > static inline void efikamx_register_leds() {}
> > #endif
> > 
> > board_init()
> > {
> > ...
> > efikamx_register_leds();
> > ...
> > }
> > 
> > What do you think ? Cheers
> IMHO it's better to register all devices independently of the available
> drivers.  So for me the used approach is OK.

For me this approach is also ok. I just applied this whole series.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
