From: broonie@kernel.org (Mark Brown)
Date: Sun, 19 Feb 2017 16:30:52 +0000
Subject: [PATCH v2 2/6] spi: davinci: enable DMA when channels are
 defined in DT
In-Reply-To: <1487327904-28311-3-git-send-email-fisaksen@baylibre.com>
References: <1487327904-28311-1-git-send-email-fisaksen@baylibre.com>
 <1487327904-28311-3-git-send-email-fisaksen@baylibre.com>
Message-ID: <20170219163052.hfs37ljvnt6sduai@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2017 at 11:38:20AM +0100, Frode Isaksen wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> When booting with DT the SPI driver is always using
> the SPI_IO_TYPE_INTR mode to transfer data even if DMA channels are
> defined in the DT.

This looks good but I'll hold off on applying it without patch 1 in case
it introduces regressions for existing systems due to switching to DMA
but not handling vmalloc() mappings.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170219/5355c65d/attachment.sig>
