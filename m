From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Mon, 30 Nov 2009 15:32:23 +0000
Subject: Get rid of IRQF_DISABLED - (was [PATCH] genirq: warn about
	IRQF_SHARED|IRQF_DISABLED)
In-Reply-To: <20091130150100.GB7028@n2100.arm.linux.org.uk>
References: <1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259578067-29169-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.0911301225110.24119@localhost.localdomain>
	<1259589780.26472.18.camel@laptop>
	<alpine.LFD.2.00.0911301519120.24119@localhost.localdomain>
	<20091130144702.14bea0ee@lxorguk.ukuu.org.uk>
	<20091130150100.GB7028@n2100.arm.linux.org.uk>
Message-ID: <20091130153223.0e510a9b@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Nov 2009 15:01:00 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Mon, Nov 30, 2009 at 02:47:02PM +0000, Alan Cox wrote:
> > SHARED|DISABLED ought to WARN_ON() and if that doesn't motivate people
> > then return -EINVAL.
> 
> That is an impossibility.  There is hardware out there (AT91) where
> the timer interrupt is shared with other peripherals, and you end
> up with a mixture of irqs-disabled and irqs-enabled handlers sharing
> the same interrupt.

Well that will encourage people to fix it.

> My point is that if we outlaw irqs-disabled shared interrupts, it puts
> Atmel AT91 support into immediate difficulties.

If a driver disables the timer irq across a tick aren't you already in
trouble ?
