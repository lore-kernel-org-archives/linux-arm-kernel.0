From: frans.klaver@xsens.com (Frans Klaver)
Date: Wed, 10 Sep 2014 16:15:55 +0200
Subject: [PATCH v8 00/18] 8250-core based serial driver for OMAP + DMA
In-Reply-To: <540F57E0.8030404@linutronix.de>
References: <1409943773-7874-1-git-send-email-bigeasy@linutronix.de>
 <20140908144616.GA22315@ci00147.xsens-tech.local>
 <20140908151501.GA22584@linutronix.de>
 <20140908183353.GB4686@ci00147.xsens-tech.local>
 <540F57E0.8030404@linutronix.de>
Message-ID: <20140910141554.GC22315@ci00147.xsens-tech.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 09, 2014 at 09:41:20PM +0200, Sebastian Andrzej Siewior wrote:
> On 09/08/2014 08:33 PM, Frans Klaver wrote:
> > Thanks. I'll give it a spin on Wednesday.
> 
> Could you please pull the upcoming v9 first?
> 
>  git://git.breakpoint.cc/bigeasy/linux.git uart_v9_pre1
> 
> This solves a few of my am335x related issues.

Using v9_pre1, I get a kernel panic in edma_dma_pause() on echan->edesc
being NULL. I do get data before this happens. This is at high speed,
high rate. No mention of the irq having too much to do, though. The more
data I transmit, the more likely this is to occur.

I don't currently have the setup to lower the baudrate. I would probably
need to reproduce this on a beaglebone, instead of our custom board.
I'll see if I can do that.

If you need more info, just let me know.

Thanks,
Frans
