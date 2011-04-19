From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 19 Apr 2011 08:25:43 +0200
Subject: [PATCH 03/10] clk: Make NULL a valid clock again
In-Reply-To: <1303174420.2801.18.camel@pororo>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-4-git-send-email-s.hauer@pengutronix.de>
	<1303174420.2801.18.camel@pororo>
Message-ID: <20110419062543.GQ14770@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy,

On Tue, Apr 19, 2011 at 08:53:40AM +0800, Jeremy Kerr wrote:
> Hi Sascha,
> 
> > NULL used to be a valid clock. This patch makes the common struct
> > clk stuff work with this. Instead of crashing we return sane default
> > values for this dummy clock, that is: can always be prepared, enabled,
> > rate unkown and no set rate.
> 
> Although I'm not totally averse to this change, I've been trying to
> avoid allowing NULL clocks - it seems to be a little 'messy' to allows
> clocks that don't have any possible operations on them, and could hide
> error cases where clock pointers have not been correctly initialised.
> 
> However, I understand that this may be required for flexibility between
> machines, and in that case would make sense. Is that what you're
> intending this for?

I intended to use NULL clocks but didn't do it then. The patch was
already created, so I posted it. I think We could equally well create a
dummy clock which can be used by all architectures. People (including
me) never really got used to NULL clocks and it's been a source of
confusion since they have been introduced.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
