From: jamie@shareable.org (Jamie Lokier)
Date: Sun, 29 Nov 2009 02:31:18 +0000
Subject: [PATCH] warn about shared irqs requesting IRQF_DISABLED
	registered with setup_irq
In-Reply-To: <alpine.LFD.2.00.0911282239430.24119@localhost.localdomain>
References: <20091127195857.GB28193@n2100.arm.linux.org.uk>
	<1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.0911272234460.24119@localhost.localdomain>
	<20091128200344.GA1272@pengutronix.de>
	<alpine.LFD.2.00.0911282239430.24119@localhost.localdomain>
Message-ID: <20091129023118.GA21529@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Gleixner wrote:
> What about analysing the code and verifying that the setup order is
> correct ?
> 
> Adding save/restore_irq just because you have no clue what the code
> does is utter nonsense.

Wouldn't it be quite a lot nicer if generic setup moved the
IRQF_DISABLED handler to be first in the list, if that actually works
in a useful way rather than simply being a quirk that irqs are
disabled for the first one?

-- Jamie
