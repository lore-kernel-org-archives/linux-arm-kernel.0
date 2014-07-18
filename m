From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Fri, 18 Jul 2014 17:36:24 +0200
Subject: [PATCH 4/6] net/macb: add RX checksum offload feature
In-Reply-To: <f29965fee23dc0de99b388373017efeffa1aac10.1405689937.git.cyrille.pitchen@atmel.com>
References: <cover.1405689937.git.cyrille.pitchen@atmel.com>
 <f29965fee23dc0de99b388373017efeffa1aac10.1405689937.git.cyrille.pitchen@atmel.com>
Message-ID: <1405697784.10255.99.camel@edumazet-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-07-18 at 16:21 +0200, Cyrille Pitchen wrote:
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> ---
>  drivers/net/ethernet/cadence/macb.c | 29 ++++++++++++++++++++++++++++-
>  drivers/net/ethernet/cadence/macb.h |  2 ++
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.c b/drivers/net/ethernet/cadence/macb.c
> index 9bdcd1b..6acd6e2 100644
> --- a/drivers/net/ethernet/cadence/macb.c
> +++ b/drivers/net/ethernet/cadence/macb.c
> @@ -766,6 +766,8 @@ static int gem_rx(struct macb *bp, int budget)
>  
>  		skb->protocol = eth_type_trans(skb, bp->dev);
>  		skb_checksum_none_assert(skb);
> +		if (bp->dev->features & NETIF_F_RXCSUM)
> +			skb->ip_summed = CHECKSUM_UNNECESSARY;
>  


Really ?

If this is what you meant, this deserves a big and fat comment.
