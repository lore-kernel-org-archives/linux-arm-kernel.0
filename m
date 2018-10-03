From: broonie@kernel.org (Mark Brown)
Date: Wed, 3 Oct 2018 16:22:55 +0100
Subject: [PATCH] spi: pxa2xx: Mark expected switch fall-through
In-Reply-To: <20181003121211.GA28108@embeddedor.com>
References: <20181003121211.GA28108@embeddedor.com>
Message-ID: <20181003152255.GE7132@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 03, 2018 at 02:12:11PM +0200, Gustavo A. R. Silva wrote:

>  			switch (drv_data->n_bytes) {
>  			case 4:
>  				bytes_left >>= 1;
> +				/* Fall through */
>  			case 2:
>  				bytes_left >>= 1;
>  			}

I think this code is just being too cute and it'd be better to just
rewrite it to directly do the expected number of shifts directly in each
case and have break statements; your fix is good but still not ideal for
readability I think.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181003/7c2fbfa9/attachment.sig>
