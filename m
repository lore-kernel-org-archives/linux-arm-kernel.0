From: broonie@kernel.org (Mark Brown)
Date: Tue, 15 Apr 2014 12:39:49 +0100
Subject: [PATCH 2/2] spi: sirf: decrease the interrupt count and latency
 of PIO mode
In-Reply-To: <1397546700-21605-2-git-send-email-21cnbao@gmail.com>
References: <1397546700-21605-1-git-send-email-21cnbao@gmail.com>
 <1397546700-21605-2-git-send-email-21cnbao@gmail.com>
Message-ID: <20140415113949.GS12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 03:25:00PM +0800, Barry Song wrote:

> +	for (;;) {

> +		writel(0, sspi->base + SIRFSOC_SPI_RXFIFO_OP);
> +		writel(0, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
> +		if (sspi->left_tx_word == 0 && sspi->left_rx_word == 0)
> +			break;
> +	}

This would be clearer as a do { } while loop.  Otherwise this looks OK
from a first read through, though the diffstat is pretty horrible.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140415/e3299a80/attachment.sig>
