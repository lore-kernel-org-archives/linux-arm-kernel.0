From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 19 Jul 2011 17:23:23 +0200
Subject: [PATCH] gpio/mxc/mxs: fix build error introduced by the reanming
	of irq_gc_ack()
In-Reply-To: <20110719125917.GK3838@S2100-06.ap.freescale.net>
References: <1311046444-25423-1-git-send-email-shawn.guo@linaro.org>
	<4E257ACD.6080608@ru.mvista.com>
	<20110719125917.GK3838@S2100-06.ap.freescale.net>
Message-ID: <20110719152323.GA6628@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

> > >  	ct = gc->chip_types;
> > >-	ct->chip.irq_ack = irq_gc_ack,
> > >+	ct->chip.irq_ack = irq_gc_ack_set_bit,
> > 
> >    There should be semicolon rathern than comma at the end.
> > 
> Thanks, Sergei.  I'm pretty surprised that gcc did not help me there.
> > >  	ct->chip.irq_mask = irq_gc_mask_clr_bit;
That's because using a comma is valid C, too.
It just assigns ct->chip.irq_ack as a side effect of the
expression

	ct->chip.irq_ack = irq_gc_ack_set_bit, ct->chip.irq_unmask = irq_gc_mask_set_bit;

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
