From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 31 Mar 2016 14:45:37 +0800
Subject: [PATCH] net: mvneta: remove useless RX descriptor prefetch
In-Reply-To: <1459406190-2334-1-git-send-email-jszhang@marvell.com>
References: <1459406190-2334-1-git-send-email-jszhang@marvell.com>
Message-ID: <20160331144537.20f04a8c@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

+ linux arm kernel

On Thu, 31 Mar 2016 14:36:30 +0800 Jisheng Zhang wrote:

> The rx descriptors are allocated using dma_alloc_coherent, so prefetch
> doesn't really happen at all.

This is for RFC, I'm sorry to send it without changing its title -- s/PATCH/RFC.

I'm not sure whether there's any benefit to prefetch on space allocated from
dma_alloc_coherent.

Thanks

> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/net/ethernet/marvell/mvneta.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 5880871..6c09a27 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -757,7 +757,6 @@ mvneta_rxq_next_desc_get(struct mvneta_rx_queue *rxq)
>  	int rx_desc = rxq->next_desc_to_proc;
>  
>  	rxq->next_desc_to_proc = MVNETA_QUEUE_NEXT_DESC(rxq, rx_desc);
> -	prefetch(rxq->descs + rxq->next_desc_to_proc);
>  	return rxq->descs + rx_desc;
>  }
>  
