From: Alexey.Brodkin@synopsys.com (Alexey Brodkin)
Date: Fri, 11 May 2018 12:44:23 +0000
Subject: [PATCH 03/20] arc: use generic dma_noncoherent_ops
In-Reply-To: <20180511075945.16548-4-hch@lst.de>
References: <20180511075945.16548-1-hch@lst.de>
 <20180511075945.16548-4-hch@lst.de>
Message-ID: <1526042662.19036.31.camel@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoph,

On Fri, 2018-05-11 at 09:59 +0200, Christoph Hellwig wrote:
> Switch to the generic noncoherent direct mapping implementation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arc/Kconfig                   |   4 +
>  arch/arc/include/asm/Kbuild        |   1 +
>  arch/arc/include/asm/dma-mapping.h |  21 -----
>  arch/arc/mm/dma.c                  | 141 +++--------------------------
>  4 files changed, 19 insertions(+), 148 deletions(-)
>  delete mode 100644 arch/arc/include/asm/dma-mapping.h

Sorry I didn't try your proposed fix earlier - was away for a couple of days.

But that newer version with fixed lib/dma-noncoherent.c still doesn't work on ARC.

USB ECHI controller fails like that:
------------------------->8-------------------------
usb 1-1: new high-speed USB device number 2 using ehci-platform
usb 1-1: can't set config #1, error -32
------------------------->8-------------------------

Again with entire series reverted USB starts to work.
Let's wait for other arches previously affected to update on their status.

-Alexey
