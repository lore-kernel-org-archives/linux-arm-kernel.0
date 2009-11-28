From: david-b@pacbell.net (David Brownell)
Date: Sat, 28 Nov 2009 14:13:13 -0800
Subject: [PATCH] warn about shared irqs requesting IRQF_DISABLED
	registered with setup_irq
In-Reply-To: <alpine.LFD.2.00.0911282239430.24119@localhost.localdomain>
References: <20091127195857.GB28193@n2100.arm.linux.org.uk>
	<20091128200344.GA1272@pengutronix.de>
	<alpine.LFD.2.00.0911282239430.24119@localhost.localdomain>
Message-ID: <200911281413.14142.david-b@pacbell.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 28 November 2009, Thomas Gleixner wrote:
> What about analysing the code and verifying that the setup order is
> correct ?

Better to not care too much about setup order.  Sometimes it's
unavoidable -- X initializes before Y "or else..." -- but the
patch I saw was just reporting goofage better.


> Adding save/restore_irq just because you have no clue what the code
> does is utter nonsense.

Absolutely.  If that helps, find and fix the real bug.
