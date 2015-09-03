From: broonie@kernel.org (Mark Brown)
Date: Thu, 3 Sep 2015 13:54:29 +0100
Subject: [PATCH v3 8/9] spi: rockchip: modify DMA max burst to 1
In-Reply-To: <1441101524-1700-1-git-send-email-shawn.lin@rock-chips.com>
References: <1441101381-1329-1-git-send-email-shawn.lin@rock-chips.com>
 <1441101524-1700-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <20150903125429.GA12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 01, 2015 at 05:58:44PM +0800, Shawn Lin wrote:

> Generic dma controller on Rockchips' platform cannot support
> DMAFLUSHP instruction which make dma to flush the req of non-aligned
> or non-multiple of what we need. That will cause an unrecoverable
> dma bus error. The saftest way is to set dma max burst to 1.

If this is a quirk of the DMA controller why is it being fixed with a
property specific to the SPI controller?  Can't the DMA controller just
override the burst size?

> +#define ROCKCHIP_SPI_BORKEN_BURST_LEN (1<<0) /* broken burst len*/

This is misspelt.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150903/c314d56f/attachment.sig>
