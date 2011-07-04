From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Jul 2011 00:25:15 +0100
Subject: Future of S3C6410 platform
In-Reply-To: <1695702.ThOPKvqyiE@flatron>
References: <2635745.FvrjgPkNLz@flatron> <201107042239.41833.arnd@arndb.de>
	<20110704213921.GL21138@trinity.fluff.org>
	<1695702.ThOPKvqyiE@flatron>
Message-ID: <20110704232515.GL8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 01:10:11AM +0200, Tomasz Figa wrote:
> For me (on GT-i5700) both fb and adc, after leaving the bootloader, end up 
> with unhandled interrupts and calling request_irq leads to kernel crash 
> because an interrupt fires before all driver data get initialized.

We really should have a debug mode for that so developers can find
that stuff really easily.  We already do this for IRQF_SHARED
interrupts, but not !IRQF_SHARED.  Thomas, any opinion?
