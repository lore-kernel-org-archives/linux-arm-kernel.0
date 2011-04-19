From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Apr 2011 10:20:49 +0100
Subject: [PATCH] mmci: sync DATAEND irq with dma transfer done
In-Reply-To: <1303203754-1731-1-git-send-email-linus.walleij@stericsson.com>
References: <1303203754-1731-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110419092049.GC22799@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2011 at 11:02:34AM +0200, Linus Walleij wrote:
> From: Ulf Hansson <ulf.hansson@stericsson.com>
> 
> The end of a dma job must be synced with a DATAEND irq. This will
> prevent the mmci driver from ending the mmc request before the
> dma driver is completely done. By using DMA_PREP_INTERRUPT we
> register a callback function which will is called when from the
> dma driver when the dma transfer is completed.

Why is what we currently do not sufficient?

This will break the detection of dead DMA controllers like on the ARM
reference platforms, as I've said before.
