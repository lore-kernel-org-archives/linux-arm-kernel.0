From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Jan 2011 22:29:30 +0000
Subject: [PATCH] arm: Improve MMC performance on Versatile Express
In-Reply-To: <alpine.LFD.2.00.1101211655110.8580@xanadu.home>
References: <1295618352-26432-1-git-send-email-pawel.moll@arm.com>
	<alpine.LFD.2.00.1101211456200.8580@xanadu.home>
	<20110121215110.GD23151@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101211655110.8580@xanadu.home>
Message-ID: <20110121222930.GF23151@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 05:20:57PM -0500, Nicolas Pitre wrote:
> The only solution in that case is to give top priority to the FIFO IRQ 
> and never disable IRQs when in interrupt context, except for that FIFO 
> servicing handler which should keep IRQs masked out throughout.  In any 
> case this would certainly be only a hack for badly misdesigned hardware.

Not possible anymore.  The kernel's IRQ handling has changed such that
generic code now ensures that IRQs are disabled irrespective of the
IRQF_DISABLED flag.  All IRQ handlers are called with IRQs disabled,
and they remain that way until they call local_irq_enable().
