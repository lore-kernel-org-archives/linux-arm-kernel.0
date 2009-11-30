From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 30 Nov 2009 10:28:49 +0100
Subject: [PATCH] warn about shared irqs requesting IRQF_DISABLED
	registered with setup_irq
In-Reply-To: <20091129151840.GA30813@shareable.org>
References: <20091127195857.GB28193@n2100.arm.linux.org.uk>
	<1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.0911272234460.24119@localhost.localdomain>
	<20091128200344.GA1272@pengutronix.de>
	<alpine.LFD.2.00.0911282239430.24119@localhost.localdomain>
	<20091129023118.GA21529@shareable.org>
	<20091129102635.GA22653@pengutronix.de>
	<20091129151840.GA30813@shareable.org>
Message-ID: <20091130092849.GA6896@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jamie,

On Sun, Nov 29, 2009 at 03:18:40PM +0000, Jamie Lokier wrote:
> According to this thread, at the moment when you have multiple
> IRQF_DISABLED|IRQF_SHARED ISRs, only the first one is run with
> interrupts disabled.
No.  When you have multiple IRQF_SHARED ISRs *all* are run with irqs
disabled if the first has IRQF_DISABLED.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
