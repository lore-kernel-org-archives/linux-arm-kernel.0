From: vinod.koul@intel.com (Vinod Koul)
Date: Sat, 5 Dec 2015 13:51:42 +0530
Subject: [PATCH] dmaengine: stm32-dma: Fix static checker warning
In-Reply-To: <1448355155-31283-1-git-send-email-cedric.madianga@gmail.com>
References: <1448355155-31283-1-git-send-email-cedric.madianga@gmail.com>
Message-ID: <20151205082142.GQ1854@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 09:52:35AM +0100, M'boumba Cedric Madianga wrote:

Title should say what is fixes rather than what flagged it off

> This patch fix an unchecked dereference warning by returning operation
> not permitted when stm32_dma_start_transfer() does not succeed to allocate
> a virtual channel descriptor.
> 

Also we give credit to reported by using tag Reported-by: xxx, pls add that
as well

> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> ---
>  drivers/dma/stm32-dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
> index 12f3a3e..0214bcf 100644
> --- a/drivers/dma/stm32-dma.c
> +++ b/drivers/dma/stm32-dma.c
> @@ -437,7 +437,7 @@ static int stm32_dma_start_transfer(struct stm32_dma_chan *chan)
>  	if (!chan->desc) {
>  		vdesc = vchan_next_desc(&chan->vchan);
>  		if (!vdesc)
> -			return 0;
> +			return -EPERM;
>  
>  		chan->desc = to_stm32_dma_desc(vdesc);
>  		chan->next_sg = 0;
> -- 
> 1.9.1
> 

-- 
~Vinod
