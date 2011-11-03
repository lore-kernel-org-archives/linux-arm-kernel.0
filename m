From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 3 Nov 2011 09:49:55 -0400 (EDT)
Subject: [PATCHv2 02/10] ARM: vic: MULTI_IRQ_HANDLER handler
In-Reply-To: <20111103125136.GL12913@n2100.arm.linux.org.uk>
References: <1317206507-18867-1-git-send-email-jamie@jamieiles.com>
	<1317206507-18867-3-git-send-email-jamie@jamieiles.com>
	<20110928203905.GB2838@ponder.secretlab.ca>
	<CACRpkdZKns-GraGp-YMD6jzOPETkvEpt9bC8HcYUmf3JUyCV3A@mail.gmail.com>
	<20110929093009.GM17204@pulham.picochip.com>
	<20111102134024.GE19187@n2100.arm.linux.org.uk>
	<20111102140811.GA22491@totoro>
	<CACRpkdY+EBkHfupO5T4SYKPxzX2L2kr8fLVMJK=JctNeYAzn2g@mail.gmail.com>
	<20111103125136.GL12913@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1111030935060.3307@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 Nov 2011, Russell King - ARM Linux wrote:

> 	stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);
> 	while (stat) {
> 		while (stat) {
> 			irq = ffs(stat) - 1;
> 			stat &= ~(1 << irq);
> 			handle_irq(irq);
> 		}
> 		stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);
> 	}

The inner loop could be a do { } while() construct to avoid evaluating 
stat twice on each outer loop itteration.  Maybe gcc is smart enough to 
notice though, maybe not.


Nicolas
