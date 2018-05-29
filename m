From: vkoul@kernel.org (Vinod)
Date: Tue, 29 May 2018 12:54:01 +0530
Subject: [RESEND PATCH] dmaengine: pxa: add a default requestor policy
In-Reply-To: <20180526095418.22960-1-robert.jarzmik@free.fr>
References: <20180526095418.22960-1-robert.jarzmik@free.fr>
Message-ID: <20180529072401.GG5666@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26-05-18, 11:54, Robert Jarzmik wrote:
> @@ -762,6 +762,8 @@ static void pxad_free_chan_resources(struct dma_chan *dchan)
>  	dma_pool_destroy(chan->desc_pool);
>  	chan->desc_pool = NULL;
>  
> +	chan->drcmr = (u32)-1;

why not use U32_MAX for this?

-- 
~Vinod
