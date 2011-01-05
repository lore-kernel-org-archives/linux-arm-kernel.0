From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Jan 2011 20:29:39 +0000
Subject: [PATCH 1/1] arm: omap: gpio: define .disable callback for gpio
	irq chip
In-Reply-To: <20110105192425.GA24729@besouro.research.nokia.com>
References: <1294250283-18182-1-git-send-email-eduardo.valentin@nokia.com>
	<20110105181918.GB8717@n2100.arm.linux.org.uk>
	<20110105192425.GA24729@besouro.research.nokia.com>
Message-ID: <20110105202939.GC8717@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 05, 2011 at 09:24:25PM +0200, Eduardo Valentin wrote:
> > The way this works is that although it isn't disabled at that point,
> > if it never triggers, then everything remains happy.  However, if it
> > does trigger, the genirq code will then mask the interrupt and won't
> > call the handler.
> 
> Right.. I didn't see from this point. I will check how that gets unmasked.
> But even so, if I understood correctly what you described, it would still
> open a time window which the system would see at least 1 interrupt during
> the time it was not suppose to. And that can wakeup a system which  is in
> deep sleep mode, either via dynamic idle or static suspend.
> 
> It is unlikely, I know. But it can still happen. And can be avoided.

Maybe a system going into deep sleep mode should update the masked state
of the interrupts to reflect the lazy-disable state?
