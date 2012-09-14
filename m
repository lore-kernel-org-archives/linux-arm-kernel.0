From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Fri, 14 Sep 2012 08:27:14 +0530
Subject: [PATCH 1/2] dmaengine: at_hdmac: fix comment in
 atc_prep_slave_sg()
In-Reply-To: <77b1e7252fbc9a31e1ed8806e017f8bd8a4605e0.1347375975.git.nicolas.ferre@atmel.com>
References: <77b1e7252fbc9a31e1ed8806e017f8bd8a4605e0.1347375975.git.nicolas.ferre@atmel.com>
Message-ID: <1347591434.1943.6.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-09-11 at 17:21 +0200, Nicolas Ferre wrote:
> s/dma_memcpy/slave_sg/ and it is sg length that we are
> talking about.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Stable <stable@vger.kernel.org> [2.6.31+]
> ---
>  drivers/dma/at_hdmac.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 3934fcc..6c09e18 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -661,7 +661,7 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  			flags);
>  
>  	if (unlikely(!atslave || !sg_len)) {
> -		dev_dbg(chan2dev(chan), "prep_dma_memcpy: length is zero!\n");
> +		dev_dbg(chan2dev(chan), "prep_slave_sg: sg length is zero!\n");
>  		return NULL;
>  	}
Applied both, Thanks.

I will send this to Linus in couple of days


-- 
~Vinod
