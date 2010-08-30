From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 30 Aug 2010 14:55:56 +0200
Subject: [PATCH 3/3 v2] dmaengine: Add Freescale i.MX SDMA support
In-Reply-To: <AANLkTimhFAhR3sSJWo3b8_rMk5GCQfOwG0T36uEs=DjA@mail.gmail.com>
References: <1281956870-12463-1-git-send-email-s.hauer@pengutronix.de>
	<20100823174852.GB26928@pengutronix.de>
	<AANLkTimmEKfErV17RWNBO-pVCfFtFw=yJL2v92UBN0=2@mail.gmail.com>
	<201008281727.10913.marek.vasut@gmail.com>
	<20100828161858.GI1473@pengutronix.de>
	<AANLkTimhFAhR3sSJWo3b8_rMk5GCQfOwG0T36uEs=DjA@mail.gmail.com>
Message-ID: <20100830125556.GL1473@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 29, 2010 at 02:35:01PM +0200, Linus Walleij wrote:
> 2010/8/28 Sascha Hauer <s.hauer@pengutronix.de>:
> 
> > Peripherals integrated into a SoC like the SDMA engine here are
> > normally accessible in native endianess and thus need the __raw_*
> > functions.
> 
> So the SDMA actually switch and twist around the endianness of
> its registers if it's synthesized into a bigendian version of the system?
> 
> Or hardware-dynamically even depending on the setting of the
> endianness bit in the ARM core?

I think it's the bus between the ARM core and the periherals which
changes the endianess. I have never tried running an i.MX in big endian
mode, so I can only guess how the system really behaves in BE mode.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
