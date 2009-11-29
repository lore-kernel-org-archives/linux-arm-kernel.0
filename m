From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 29 Nov 2009 11:26:35 +0100
Subject: [PATCH] warn about shared irqs requesting IRQF_DISABLED
	registered with setup_irq
In-Reply-To: <20091129023118.GA21529@shareable.org>
References: <20091127195857.GB28193@n2100.arm.linux.org.uk>
	<1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.0911272234460.24119@localhost.localdomain>
	<20091128200344.GA1272@pengutronix.de>
	<alpine.LFD.2.00.0911282239430.24119@localhost.localdomain>
	<20091129023118.GA21529@shareable.org>
Message-ID: <20091129102635.GA22653@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sun, Nov 29, 2009 at 02:31:18AM +0000, Jamie Lokier wrote:
> Thomas Gleixner wrote:
> > What about analysing the code and verifying that the setup order is
> > correct ?
> > 
> > Adding save/restore_irq just because you have no clue what the code
> > does is utter nonsense.
> 
> Wouldn't it be quite a lot nicer if generic setup moved the
> IRQF_DISABLED handler to be first in the list, if that actually works
> in a useful way rather than simply being a quirk that irqs are
> disabled for the first one?
Hmm, what happens if an ISR runs with irqs disabled even though it
doesn't expect it?  I wouldn't bet that nothing breaks.

IMHO the best is if a warning is printed or registering fails if shared
irq actions don't agree about wanting IRQF_DISABLED.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
