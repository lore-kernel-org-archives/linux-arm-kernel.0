From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 3 Jun 2012 21:37:49 +0100
Subject: [PATCH v4] MTD: LPC32xx SLC NAND driver
In-Reply-To: <4FCBBFD4.9090401@antcom.de>
References: <1338748689-29645-1-git-send-email-stigge@antcom.de>
 <20120603190932.GB23368@n2100.arm.linux.org.uk> <4FCBBFD4.9090401@antcom.de>
Message-ID: <20120603203749.GD23368@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 03, 2012 at 09:49:40PM +0200, Roland Stigge wrote:
> Hi!
> 
> Thanks for the suggestions!
> 
> On 03/06/12 21:09, Russell King - ARM Linux wrote:
> >> +	dma_async_issue_pending(host->dma_chan);
> >> +
> >> +	wait_for_completion_timeout(&host->comp, msecs_to_jiffies(1000));
> > 
> > What about unmapping the buffer upon completion?
> 
> OK - by not specifying DMA_COMPL_SKIP_*_UNMAP in flags, I was thinking
> that this happens somehow magically. ;-) But maybe I was just confused.

Slave transfers should never be automatically unmapped by the DMA engine
driver.
