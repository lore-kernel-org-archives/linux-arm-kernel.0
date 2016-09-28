From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 28 Sep 2016 08:47:10 +0530
Subject: [PATCH v3 6/9] dmaengine: ti-dma-crossbar: Fix of_device_id data
 parameter usage
In-Reply-To: <20160921124135.11849-7-peter.ujfalusi@ti.com>
References: <20160921124135.11849-1-peter.ujfalusi@ti.com>
 <20160921124135.11849-7-peter.ujfalusi@ti.com>
Message-ID: <20160928031709.GJ2467@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2016 at 03:41:32PM +0300, Peter Ujfalusi wrote:
> @@ -395,7 +403,7 @@ static int ti_dra7_xbar_probe(struct platform_device *pdev)
>  
>  	xbar->dmarouter.dev = &pdev->dev;
>  	xbar->dmarouter.route_free = ti_dra7_xbar_free;
> -	xbar->dma_offset = (u32)match->data;
> +	xbar->dma_offset = *(u32*)match->data;
			     ^^^^
we need space between u32 and *

>  	mutex_init(&xbar->mutex);
>  	platform_set_drvdata(pdev, xbar);
> @@ -428,7 +436,7 @@ static int ti_dma_xbar_probe(struct platform_device *pdev)
>  	if (unlikely(!match))
>  		return -EINVAL;
>  
> -	switch ((u32)match->data) {
> +	switch (*(u32*)match->data) {

here too please

-- 
~Vinod
