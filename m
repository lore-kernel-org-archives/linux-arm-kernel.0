From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 19 Aug 2013 17:13:10 +0200
Subject: [PATCH v2 2/7] pinctrl: imx27: imx27 pincontrol driver
In-Reply-To: <1376923502.112235348@f25.i.mail.ru>
References: <1376921234-26682-1-git-send-email-mpa@pengutronix.de>
 <1376921234-26682-3-git-send-email-mpa@pengutronix.de>
 <1376923502.112235348@f25.i.mail.ru>
Message-ID: <20130819151123.GA24669@s25.your-server.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 06:45:02PM +0400, Alexander Shiyan wrote:
> > imx27 pincontrol driver using the imx1 core driver. The DT bindings are
> > similar to other imx pincontrol drivers.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> [...]
> > diff --git a/drivers/pinctrl/pinctrl-imx27.c b/drivers/pinctrl/pinctrl-imx27.c
> [...]
> > +	MX27_PAD_ATA_DATA15 = PAD_ID(PF, 23),
> > +	MX27_PAD_UNUSED15 = PAD_ID(PF, 24),
> > +	MX27_PAD_UNUSED16 = PAD_ID(PF, 25),
> > +	MX27_PAD_UNUSED17 = PAD_ID(PF, 26),
> > +	MX27_PAD_UNUSED18 = PAD_ID(PF, 27),
> > +	MX27_PAD_UNUSED19 = PAD_ID(PF, 28),
> > +	MX27_PAD_UNUSED20 = PAD_ID(PF, 29),
> > +	MX27_PAD_UNUSED21 = PAD_ID(PF, 30),
> > +	MX27_PAD_UNUSED22 = PAD_ID(PF, 31),
> 
> No PF24-PF31 pads in CPU.
> Is it worth it to have these definitions?

I think it's better for completeness. As every port has the registers to
store the states for 32 pads, I would prefer to keep UNUSED definitions.

Regards,

Markus

> 
> ---

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
