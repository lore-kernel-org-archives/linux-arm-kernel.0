From: timur@codeaurora.org (Timur Tabi)
Date: Sat, 7 Nov 2015 23:13:57 -0600
Subject: [PATCH V3 3/4] dmaselftest: add memcpy selftest support functions
In-Reply-To: <1446958380-23298-4-git-send-email-okaya@codeaurora.org>
References: <1446958380-23298-1-git-send-email-okaya@codeaurora.org>
 <1446958380-23298-4-git-send-email-okaya@codeaurora.org>
Message-ID: <563EDA15.7070606@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sinan Kaya wrote:

> +static int dma_selftest_sg(struct dma_device *dmadev,
> +			struct dma_chan *dma_chanptr, u64 size,
> +			unsigned long flags)
> +{
> +	dma_addr_t src_dma, dest_dma, dest_dma_it;
> +	u8 *dest_buf;
> +	u32 i, j = 0;
> +	dma_cookie_t cookie;
> +	struct dma_async_tx_descriptor *tx;
> +	int err = 0;
> +	int ret;
> +	struct sg_table sg_table;
> +	struct scatterlist	*sg;
> +	int nents = 10, count;
> +	bool free_channel = 1;

Booleans are either 'true' or 'false'.

> +static int dma_selftest_mapsngle(struct device *dev)
> +{
> +	u32 buf_size = 256;
> +	char *src;
> +	int ret = -ENOMEM;
> +	dma_addr_t dma_src;
> +
> +	src = kmalloc(buf_size, GFP_KERNEL);
> +	if (!src)
> +		return -ENOMEM;
> +
> +	strcpy(src, "hello world");

kstrdup()?

And why kmalloc anyway?  Why not leave it on the stack?

	char src[] = "hello world";

?


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
