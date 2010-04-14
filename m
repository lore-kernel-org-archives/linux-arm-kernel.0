From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 14 Apr 2010 08:51:31 +0200
Subject: [PATCH 2.6.34-rc4 1/8] mx5: Add registration of GPIOs for MX51
	Babbage board.
In-Reply-To: <86A0E76937111F4C92FABEC0A2098851046C7A62@az33exm21>
References: <1271175030-3635-1-git-send-email-Dinh.Nguyen@freescale.com>
	<20100413164532.GM30801@buzzloop.caiaq.de>
	<86A0E76937111F4C92FABEC0A2098851046C7A62@az33exm21>
Message-ID: <20100414065131.GD7882@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 13, 2010 at 12:36:07PM -0700, Nguyen Dinh-R00091 wrote:
> > +
> > +#ifdef MXC_GPIO_SPLIT_IRQ_2
> 
> Where is that macro defined?
> [Dinh-FSL] - This macro is optional so that the interrupts can be broken
> up into 2 sets.

What's the purpose of doing so?

Such compile time depencies are not a good idea since the board may want
to decide whether to split the interrupts or not. Note that we support
kernels for more than one board.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
