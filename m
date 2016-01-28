From: johannes@sipsolutions.net (Johannes Berg)
Date: Thu, 28 Jan 2016 23:14:19 +0100
Subject: [PATCH net-next 08/40] net: fec: move cbd_bufaddr assignment
 closer to the mapping function
In-Reply-To: <1725152.bhtFKTSjnb@wuerfel>
References: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
 <1454016364-30985-9-git-send-email-troy.kisky@boundarydevices.com>
 <1725152.bhtFKTSjnb@wuerfel>
Message-ID: <1454019259.2332.17.camel@sipsolutions.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-01-28 at 23:02 +0100, Arnd Bergmann wrote:
> On Thursday 28 January 2016 14:25:32 Troy Kisky wrote:
> > Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> > ---
> > ?drivers/net/ethernet/freescale/fec_main.c | 4 ++--
> > ?1 file changed, 2 insertions(+), 2 deletions(-)
> 
> [note: missing changelog?]
> 
> > diff --git a/drivers/net/ethernet/freescale/fec_main.c
> > b/drivers/net/ethernet/freescale/fec_main.c
> > index b87f80d..15a93f90 100644
> > --- a/drivers/net/ethernet/freescale/fec_main.c
> > +++ b/drivers/net/ethernet/freescale/fec_main.c
> > @@ -476,6 +476,8 @@ static int fec_enet_txq_submit_skb(struct
> > fec_enet_priv_tx_q *txq,
> > ?				estatus |= BD_ENET_TX_TS;
> > ?		}
> > ?	}
> > +	bdp->cbd_bufaddr = addr;
> > +	bdp->cbd_datlen = buflen;
> > ?
> > ?	if (fep->bufdesc_ex) {
> > ?
> > @@ -499,8 +501,6 @@ static int fec_enet_txq_submit_skb(struct
> > fec_enet_priv_tx_q *txq,
> > ?	/* Save skb pointer */
> > ?	txq->tx_skbuff[index] = skb;
> > ?
> > -	bdp->cbd_datlen = buflen;
> > -	bdp->cbd_bufaddr = addr;
> > ?	/* Make sure the updates to rest of the descriptor are
> > performed before
> > ?	?* transferring ownership.
> > ?	?*/
> > 
> 
> This patch and others in the series conflicts with the bugfix "net:
> fec: make driver endian-safe" that Johannes sent this week. Can you
> include his fix in your series and ensure that all descriptor
> accesses are done in an endian-safe way?
> 

My fixes are already in net.git, so you should base on a current
net.git or on net-next.git after net.git is merged there (which davem
usually does after Linus merges from him, IIRC)

johannes
