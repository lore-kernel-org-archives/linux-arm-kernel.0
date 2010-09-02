From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 2 Sep 2010 07:03:49 +0200
Subject: [PATCH] ARM: Implement cpu_v7_reset.
In-Reply-To: <4C7EC313.7050705@codeaurora.org>
References: <1283349719-21115-1-git-send-email-linus.walleij@stericsson.com>
	<4C7EC313.7050705@codeaurora.org>
Message-ID: <20100902050349.GA14214@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> > +#ifdef CONFIG_MMU
> > +	mcr     p15, 0, ip, c8, c7, 0           @ invalidate I & D TLBs
> > +#endif
> > +	mrc     p15, 0, ip, c1, c0, 0           @ ctrl register
> > +	bic     ip, ip, #0x000f                 @ ............wcam
> > +	bic     ip, ip, #0x1100                 @ ...i...s........
> > +	mcr     p15, 0, ip, c1, c0, 0           @ ctrl register
> 
> On a related note, I was always a bit confused since proc-v6 and proc-v7
> don't turn off the MMU in their cpu_reset functions, which doesn't seem
> correct with respect to Documentation/arm/Booting. Is it necessary to
> turn off the MMU when kexec'ing the kernel? Last time I tried kexec'ing
> on a v6 it worked fine without turning off the MMU.
The boot process isn't that strict.  Having the MMU off is the safest,
but e.g. having an 1:1 mapping worked OK last time I checked.  But this
has to be considered to be by chance and it might not work with 2.6.37.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
