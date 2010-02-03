From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 3 Feb 2010 21:49:36 +0100
Subject: [PATCH 11/13] ARM: LPC32XX: printascii() output and irq
	support functions
In-Reply-To: <083DF309106F364B939360100EC290F805C8B7879A@eu1rdcrdc1wx030.exi.nxp.com>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
	<1264643011-17390-12-git-send-email-wellsk40@gmail.com>
	<20100203165025.GM11354@pengutronix.de>
	<083DF309106F364B939360100EC290F805C8B7879A@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <20100203204936.GF20113@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> > 
> > You could make this easier by only handling MIC(?) interrupts and make
> > SIC1 and SIC2 use a chained handler.  Then you can use
> > get_irqnr_preamble for microoptimisation.
> > 
> 
> I'll take a look at this. I'm not entirely sure it can be made more
> optimal than how it's implemented now. Even SIC1 and SIC2 interrupts
> need to be routed via the MIC (The MIC interrupt will always fire
> when a SIC1 or SIC2 interrupt occur.) This code is very tight right
> now.
Yes, I got that.  You can look at
board_a9m9750dev_init_irq() (arch/arm/mach-ns9xxx/board-a9m9750dev.c)
for an example.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
