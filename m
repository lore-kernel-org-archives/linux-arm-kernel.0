From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 20 Aug 2015 11:18:28 +0530
Subject: [PATCH v1 3/4] Crypto: Add support for APM X-Gene SoC CRC32C h/w
 accelerator driver
In-Reply-To: <1438258268-3099-4-git-send-email-rsahu@apm.com>
References: <1438258268-3099-1-git-send-email-rsahu@apm.com>
 <1438258268-3099-4-git-send-email-rsahu@apm.com>
Message-ID: <20150820054828.GY13546@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 30, 2015 at 05:41:07PM +0530, Rameshwar Prasad Sahu wrote:
> +	nents = sg_nents(req->src);
> +	sg_count = dma_map_sg(dev, req->src, nents, DMA_TO_DEVICE);
> +	if (!sg_count) {
> +		dev_err(dev, "Failed to map src sg");
> +		return -ENOMEM;
mapping error shouldn't be no mem error

> +	}
> +
> +	if (sg_count > XGENE_DMA_MAX_FLYBY_SRC_CNT) {
> +		dev_err(dev, "Unsupported src sg len\n");
would be worth printing length

> +		goto err;
> +	}
> +
> +	flags = DMA_CTRL_ACK;
why ACK?

> +
> +	tx = dchan->device->device_prep_dma_crc32c(dchan, req->src,
> +						   req->nbytes,
> +						   reqctx->seed,
> +						   req->result,
> +						   flags);
We should add helper for this

-- 
~Vinod
