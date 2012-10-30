From: David.Laight@ACULAB.COM (David Laight)
Date: Tue, 30 Oct 2012 11:12:53 -0000
Subject: [PATCH v3 06/10] net/macb: clean up ring buffer logic
In-Reply-To: <75eb5df193c504e68ebff7d6a6a88d9a1cc678cb.1351591858.git.nicolas.ferre@atmel.com>
References: <cover.1351591858.git.nicolas.ferre@atmel.com>
 <75eb5df193c504e68ebff7d6a6a88d9a1cc678cb.1351591858.git.nicolas.ferre@atmel.com>
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B707D@saturn3.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Instead of masking head and tail every time we increment them, just let them
> wrap through UINT_MAX and mask them when subscripting. Add simple accessor
> functions to do the subscripting properly to minimize the chances of messing
> this up.
...
> +static unsigned int macb_tx_ring_avail(struct macb *bp)
> +{
> +	return TX_RING_SIZE - (bp->tx_head - bp->tx_tail);
> +}

That one doesn't look quite right to me.
Surely it should be masking with 'TX_RING_SIZE - 1'

	David
