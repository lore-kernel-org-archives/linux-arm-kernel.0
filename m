From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Wed, 16 Aug 2017 08:17:42 +0200
Subject: [PATCH 1/2] dmaengine: at_xdmac: Fix compilation warning.
In-Reply-To: <878f9486ee507c227cb8835417c520b489c768c8.1502091778.git.arvind.yadav.cs@gmail.com>
References: <878f9486ee507c227cb8835417c520b489c768c8.1502091778.git.arvind.yadav.cs@gmail.com>
Message-ID: <20170816061742.g6a4chvlx3qlbdm6@rfolt0960.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 07, 2017 at 01:15:18PM +0530, Arvind Yadav wrote:
> Replace '%d' by '%zu' to fix the compilation warning:-
>    "format ?%d? expects argument of type ?int?,but argument has type ?size_t? [-Wformat=]"
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks
> ---
>  drivers/dma/at_xdmac.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index 7d4e0bc..6a3cf97 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -875,7 +875,7 @@ static inline u32 at_xdmac_align_width(struct dma_chan *chan, dma_addr_t addr)
>  	dwidth = at_xdmac_align_width(chan, src | dst | chunk->size);
>  	if (chunk->size >= (AT_XDMAC_MBR_UBC_UBLEN_MAX << dwidth)) {
>  		dev_dbg(chan2dev(chan),
> -			"%s: chunk too big (%d, max size %lu)...\n",
> +			"%s: chunk too big (%zu, max size %lu)...\n",
>  			__func__, chunk->size,
>  			AT_XDMAC_MBR_UBC_UBLEN_MAX << dwidth);
>  		return NULL;
> @@ -956,7 +956,7 @@ static inline u32 at_xdmac_align_width(struct dma_chan *chan, dma_addr_t addr)
>  	if ((xt->numf > 1) && (xt->frame_size > 1))
>  		return NULL;
>  
> -	dev_dbg(chan2dev(chan), "%s: src=%pad, dest=%pad, numf=%d, frame_size=%d, flags=0x%lx\n",
> +	dev_dbg(chan2dev(chan), "%s: src=%pad, dest=%pad, numf=%zu, frame_size=%zu, flags=0x%lx\n",
>  		__func__, &xt->src_start, &xt->dst_start,	xt->numf,
>  		xt->frame_size, flags);
>  
> @@ -990,7 +990,7 @@ static inline u32 at_xdmac_align_width(struct dma_chan *chan, dma_addr_t addr)
>  			dst_skip = chunk->size + dst_icg;
>  
>  			dev_dbg(chan2dev(chan),
> -				"%s: chunk size=%d, src icg=%d, dst icg=%d\n",
> +				"%s: chunk size=%zu, src icg=%zu, dst icg=%zu\n",
>  				__func__, chunk->size, src_icg, dst_icg);
>  
>  			desc = at_xdmac_interleaved_queue_desc(chan, atchan,
> @@ -1207,7 +1207,7 @@ static struct at_xdmac_desc *at_xdmac_memset_create_desc(struct dma_chan *chan,
>  	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
>  	struct at_xdmac_desc	*desc;
>  
> -	dev_dbg(chan2dev(chan), "%s: dest=%pad, len=%d, pattern=0x%x, flags=0x%lx\n",
> +	dev_dbg(chan2dev(chan), "%s: dest=%pad, len=%zu, pattern=0x%x, flags=0x%lx\n",
>  		__func__, &dest, len, value, flags);
>  
>  	if (unlikely(!len))
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
