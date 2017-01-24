From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Jan 2017 15:48:10 +0000
Subject: [PATCH] spi: mediatek: Manually set dma_ops for spi_master device
In-Reply-To: <20170124132519.13271-1-djkurtz@chromium.org>
References: <20170124132519.13271-1-djkurtz@chromium.org>
Message-ID: <20170124154810.ikbxaptvtg5wamzj@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 09:25:19PM +0800, Daniel Kurtz wrote:

> The master_spi device is not a platform, rather it is created
> in spi_alloc_device(), and its dma_ops are never set.

Which is good because it's not a physical device and doesn't do DMA.

> Alternatively, perhaps we should be using master->dev.parent to dma map bufs
> in the "no dma channel case".

Yes, exactly.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170124/679e1581/attachment.sig>
