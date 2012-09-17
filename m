From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Mon, 17 Sep 2012 09:03:25 +0530
Subject: [PATCH V6 2/2] dmaengine: add helper function to request a
 slave DMA channel
In-Reply-To: <1347662517-4210-3-git-send-email-jon-hunter@ti.com>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com>
 <1347662517-4210-3-git-send-email-jon-hunter@ti.com>
Message-ID: <1347852805.1943.130.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-09-14 at 17:41 -0500, Jon Hunter wrote:
> +/**
> + * dma_request_slave_channel - try to allocate an exclusive slave
> channel
> + * @dev:       pointer to client device structure
> + * @name:      slave channel name
> + */
> +struct dma_chan *dma_request_slave_channel(struct device *dev, char *name)
> +{
> +       /* If device-tree is present get slave info from here */
> +       if (dev->of_node)
> +               return of_dma_request_slave_channel(dev->of_node, name);
> +
Shouldn't this be conditionally compiled only when OF is built. I think
this might be problematic for systems which doesn't have device tree.
Or perhaps you can declare these symbols as dummy in of_dma.h when
device tree is not selected.
> +       return NULL;
> +}
> +EXPORT_SYMBOL_GPL(dma_request_slave_channel); 
-- 
~Vinod
