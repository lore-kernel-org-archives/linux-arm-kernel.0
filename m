From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 May 2016 16:44:41 +0100
Subject: [PATCH v7] spi: orion.c: Add direct access mode
In-Reply-To: <1462187964-21876-1-git-send-email-sr@denx.de>
References: <1462187964-21876-1-git-send-email-sr@denx.de>
Message-ID: <20160502154441.GJ6292@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 02, 2016 at 01:19:24PM +0200, Stefan Roese wrote:

> +	if ((orion_spi->direct_access[cs].vaddr) && (xfer->tx_buf) &&
> +	    (word_len == 8)) {
> +		unsigned int cnt = count >> 2;
> +		unsigned int rem = count % 4;

For the benefit of readers please write divisions as divisions and let
the compiler figure out if they can be turned into shifts.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160502/bf2b69b6/attachment.sig>
