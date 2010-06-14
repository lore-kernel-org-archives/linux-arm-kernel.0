From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 14 Jun 2010 11:34:59 +0200
Subject: [RFC,PATCH 1/2] Add a common struct clk
In-Reply-To: <19477.53673.644128.558827@ipc1.ka-ro>
References: <201006111557.12249.jeremy.kerr@canonical.com>
	<19473.61547.684572.647641@ipc1.ka-ro>
	<201006111718.47426.jeremy.kerr@canonical.com>
	<19474.172.742782.972629@ipc1.ka-ro>
	<20100611095839.GC10894@pengutronix.de>
	<19474.2817.333749.485028@ipc1.ka-ro>
	<1276319643.1962.181.camel@pasglop>
	<19477.52889.982995.407051@ipc1.ka-ro>
	<20100614064028.GA12159@pengutronix.de>
	<19477.53673.644128.558827@ipc1.ka-ro>
Message-ID: <20100614093459.GD12159@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> And arch/arm/plat-s3c/clock.c has the following comment:
> |/* We originally used an mutex here, but some contexts (see resume)
> | * are calling functions such as clk_set_parent() with IRQs disabled
> | * causing an BUG to be triggered.
> | */
> |DEFINE_SPINLOCK(clocks_lock);
I wonder why it's needed to reparent clocks during resume.  And where
exactly IRQs are disabled.  Hmm, this comment was initially introduced
by v2.6.28-rc7-180-gc3391e3, its commit log talks about cpufreq, not
resume.

Ben (Dooks): Is this still relevant?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
