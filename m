From: stigge@antcom.de (Roland Stigge)
Date: Thu, 20 Dec 2012 11:43:08 +0100
Subject: LPC32xx and MMCI driver
In-Reply-To: <50D2E317.6000005@precidata.com>
References: <50D2E156.20707@precidata.com> <50D2E317.6000005@precidata.com>
Message-ID: <50D2EBBC.2070803@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12/20/2012 11:06 AM, Gabriele Mondada wrote:
> Hi,
> Currently, LPC32xx plateform do not enable DMA on the mmci driver. This
> makes the driver useless because getting out data from a 64 bytes FIFO
> by interrupt is not fast enough (at standard SD-card data rate).
> 
> DMA is not enabled because LPC32xx has a bug that prevent DMA to work
> properly with the MMC controller (silicon bug, I guess). NXP did a patch
> to workaround this, but it has not been commited on the main branch. The
> patch is for linux 2.6.39.2 and does not use dmaengine.
> 
> So, I reworked this patch to make it compatible with the last kernel
> (3.7). Here it is. Have I any chance to see this patch be commited on
> the main branch?

First, thank you for the patch!

Unfortunately, it doesn't apply to v3.7 in the form it arrived in my
INBOX (mainly formatting issues, maybe MUA related?). Can you please
check and resend? I'd like to test it.

Further, there seem to be many #ifdefs in two subsystems (mmc and dma)
at once. First, maybe the LPC32XX specific pl08x_force_dma_burst() could
be moved to mmci.c since it is only used there and this would minimize
the patch to only the mmc subsystem.

And maybe at least some of the ifdefs could be removed.

The less ifdefs, the higher the chances of mainlining. ;-)

Thanks in advance,

Roland
