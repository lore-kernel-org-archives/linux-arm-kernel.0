From: David.Laight@ACULAB.COM (David Laight)
Date: Wed, 31 Oct 2012 08:57:43 -0000
Subject: [PATCH v3 06/10] net/macb: clean up ring buffer logic
In-Reply-To: <CACiLriQnQcoXFqrqNt3nkY47nR8FnXbqWjtPRp250gueHSMDmQ@mail.gmail.com>
References: <cover.1351591858.git.nicolas.ferre@atmel.com><75eb5df193c504e68ebff7d6a6a88d9a1cc678cb.1351591858.git.nicolas.ferre@atmel.com><AE90C24D6B3A694183C094C60CF0A2F6026B707D@saturn3.aculab.com>
 <CACiLriQnQcoXFqrqNt3nkY47nR8FnXbqWjtPRp250gueHSMDmQ@mail.gmail.com>
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B707F@saturn3.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Tue, Oct 30, 2012 at 4:12 AM, David Laight <David.Laight@aculab.com> wrote:
> >> Instead of masking head and tail every time we increment them, just let them
> >> wrap through UINT_MAX and mask them when subscripting. Add simple accessor
> >> functions to do the subscripting properly to minimize the chances of messing
> >> this up.
> > ...
> >> +static unsigned int macb_tx_ring_avail(struct macb *bp)
> >> +{
> >> +     return TX_RING_SIZE - (bp->tx_head - bp->tx_tail);
> >> +}
> >
> > That one doesn't look quite right to me.
> > Surely it should be masking with 'TX_RING_SIZE - 1'
> 
> Why is that? head and tail can never be more than TX_RING_SIZE apart,
> so it shouldn't make any difference.

It's a ring buffer (I presume) the pointers can be in either order.

	David
