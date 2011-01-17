From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 17 Jan 2011 10:06:20 +0100
Subject: [PATCH v4 05/10] net/fec: add dual fec support for mx28
In-Reply-To: <20110113144805.GS24920@pengutronix.de>
References: <1294297998-26930-1-git-send-email-shawn.guo@freescale.com>
	<1294297998-26930-6-git-send-email-shawn.guo@freescale.com>
	<20110113144805.GS24920@pengutronix.de>
Message-ID: <20110117090620.GN6917@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Jan 13, 2011 at 03:48:05PM +0100, Uwe Kleine-K?nig wrote:
> >  #if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
> > -    defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARCH_MXC)
> > +    defined(CONFIG_M520x) || defined(CONFIG_M532x) || \
> > +    defined(CONFIG_ARCH_MXC) || defined(CONFIG_SOC_IMX28)
> I wonder what is excluded here.  FEC depends on
> 
> 	M523x || M527x || M5272 || M528x || M520x || M532x || \
> 	MACH_MX27 || ARCH_MX35 || ARCH_MX25 || ARCH_MX5 || SOC_IMX28
> 
> so the only difference is that the latter lists M5272 which seems a bit
> redundant in the presence of M527x.
M527x = {M5271, M5275}, so it seems to me that only M5272 is excluded
here.  I don't know if it's possible to have a kernel supporting M5272
and (e.g.) M527x.  If yes, does the driver work correct on M5272 then?

Greg, it seems to me that M5272 is the exception here, not all the
others.  Would it make sense to make the above read:

	#if !defined(CONFIG_M5272)

?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
