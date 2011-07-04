From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 05 Jul 2011 01:40:04 +0200
Subject: Future of S3C6410 platform
In-Reply-To: <20110704232515.GL8286@n2100.arm.linux.org.uk>
References: <2635745.FvrjgPkNLz@flatron> <1695702.ThOPKvqyiE@flatron>
	<20110704232515.GL8286@n2100.arm.linux.org.uk>
Message-ID: <1937503.ug88JfFd8A@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 of July 2011 00:25:15 Russell King - ARM Linux wrote:
> On Tue, Jul 05, 2011 at 01:10:11AM +0200, Tomasz Figa wrote:
> > For me (on GT-i5700) both fb and adc, after leaving the bootloader, end
> > up with unhandled interrupts and calling request_irq leads to kernel
> > crash because an interrupt fires before all driver data get
> > initialized.
> 
> We really should have a debug mode for that so developers can find
> that stuff really easily.  We already do this for IRQF_SHARED
> interrupts, but not !IRQF_SHARED.  Thomas, any opinion?

Would it be possible to simulate that in a realistic way? I mean, usually when 
an interrupt fires, the driver checks the detailed cause in hardware 
registers. If we would just simulate an interrupt, wouldn't it just end up 
with finding no interrupt cause, something which shouldn't happen normally 
with "exclusive" interrupts? This also implies that not all code paths would 
be tested with such test case.
