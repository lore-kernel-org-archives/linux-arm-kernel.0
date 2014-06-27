From: broonie@kernel.org (Mark Brown)
Date: Fri, 27 Jun 2014 11:50:57 +0100
Subject: [PATCH] spi: qup: Add DMA capabilities
In-Reply-To: <1403816781-31008-1-git-send-email-agross@codeaurora.org>
References: <1403816781-31008-1-git-send-email-agross@codeaurora.org>
Message-ID: <20140627105057.GF23300@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 04:06:21PM -0500, Andy Gross wrote:

> +	if (xfer->rx_buf) {
> +		rx_dma = dma_map_single(controller->dev, xfer->rx_buf,
> +			xfer->len, DMA_FROM_DEVICE);

It would be better to use the core DMA mapping code rather than open
coding.  This code won't work for vmalloc()ed addresses, or physically
non-contiguous addresses unless there's an IOMMU fixing things up.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140627/0c812691/attachment.sig>
