From: broonie@kernel.org (Mark Brown)
Date: Mon, 9 Jan 2017 19:48:11 +0000
Subject: [RESEND] spi: davinci: Allow device tree devices to use DMA
In-Reply-To: <1483673177-31516-1-git-send-email-david@lechnology.com>
References: <1483673177-31516-1-git-send-email-david@lechnology.com>
Message-ID: <20170109194811.p3if5pzvjjaez2g3@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2017 at 09:26:17PM -0600, David Lechner wrote:

> This allows SPI devices specified in a device tree to use DMA when the
> master controller.

> Since device tree is supposed to only describe the hardware, adding such
> a configuration option to device tree would not be acceptable. So, this
> is the best we can do for now to get SPI devices working with DMA.

> Unfortunately, this excludes the possibility of using one SPI device with
> DMA and one without on the same master.

Why would you ever want to do that?  What would ever make sense about
not using DMA if it's available and the transfer is suitably large, or
conversely why would one want to force DMA even if PIO would be more
performant?

> When I originally submitted this patch, there was some discussion as to whether
> dspi->dma_rx should be changed to return an error rather than being null.

> However, I prefer it the way it is and don't see a compelling reason to change
> it.

I don't know what the above comment means, sorry (and don't recall
having seen any earlier versions of this).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170109/ce442c16/attachment.sig>
