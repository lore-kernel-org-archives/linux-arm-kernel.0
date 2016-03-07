From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 7 Mar 2016 20:24:29 +0530
Subject: [PATCH] dma: sun4i: expose block size and wait cycle
 configuration to DMA users
In-Reply-To: <1457344771-12946-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457344771-12946-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160307145429.GG11154@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 07, 2016 at 10:59:31AM +0100, Boris Brezillon wrote:
> +/* Dedicated DMA parameter register layout */
> +#define SUN4I_DDMA_PARA_DST_DATA_BLK_SIZE(n)	(((n) - 1) << 24)
> +#define SUN4I_DDMA_PARA_DST_WAIT_CYCLES(n)	(((n) - 1) << 16)
> +#define SUN4I_DDMA_PARA_SRC_DATA_BLK_SIZE(n)	(((n) - 1) << 8)
> +#define SUN4I_DDMA_PARA_SRC_WAIT_CYCLES(n)	(((n) - 1) << 0)
> +
> +/**
> + * struct sun4i_dma_chan_config - DMA channel config
> + *
> + * @para: contains information about block size and time before checking
> + *	  DRQ line. This is device specific and only applicable to dedicated
> + *	  DMA channels

What information, can you elobrate.. And why can't you use existing
dma_slave_config for this?

> + */
> +struct sun4i_dma_chan_config {
> +	u32 para;
> +};
> +
> +int sun4i_dma_set_chan_config(struct dma_chan *dchan,
> +			      const struct sun4i_dma_chan_config *cfg);
> +
> +#endif /* _SUN4I_DMA_H */

-- 
~Vinod
