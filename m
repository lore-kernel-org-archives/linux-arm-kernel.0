From: broonie@kernel.org (Mark Brown)
Date: Tue, 31 Mar 2015 15:13:21 +0100
Subject: [PATCH] spi: bitbang: only toggle bitchanges
In-Reply-To: <1427810089-14866-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1427810089-14866-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <20150331141321.GR2869@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 31, 2015 at 03:54:49PM +0200, Michael Grzeschik wrote:

>  		if ((flags & SPI_MASTER_NO_TX) == 0)
> -			setmosi(spi, word & (1 << 31));
> +			if ((word & (1 << 31)) != oldbit) {
> +				setmosi(spi, word & (1 << 31));
> +				oldbit = word & (1 << 31);
> +			}
>  		spidelay(nsecs);	/* T(setup) */

This change is fine but for legibility can you please add braces around
the outer if as well?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150331/d1710f9b/attachment.sig>
