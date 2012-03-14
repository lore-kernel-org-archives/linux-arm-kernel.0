From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 14 Mar 2012 17:26:55 +0100
Subject: [PATCH v3 2/2] DMAEngine: Add DMAEngine driver based on old MSM
 DMA APIs
In-Reply-To: <1331548364-27845-1-git-send-email-kumarrav@codeaurora.org>
References: <1331548364-27845-1-git-send-email-kumarrav@codeaurora.org>
Message-ID: <4F60C6CF.4090608@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> [...]
> +
> +struct dma_async_tx_descriptor *msm_dma_prep_interleaved(struct dma_chan *dchan,
> +					struct dma_interleaved_template *xt,
> +					unsigned long flags, void *context)
> +{
> +
> +	struct msm_dma_chan *chan;
> +	struct msm_dma_desc_sw *new;
> +	struct adm_box_cmd_t *box_cmd_vaddr;
> +	u32 *cmd_cntrl = context;
> +
> +	if (!dchan)
> +		return ERR_PTR(-EINVAL);

This is supposed to return either NULL or a valid descriptor.

> +
> +	if (!xt)
> +		return ERR_PTR(-EINVAL);
> [...
