From: joe@perches.com (Joe Perches)
Date: Tue, 04 Feb 2014 13:17:28 -0800
Subject: [Patch v5 1/2] dmaengine: add Qualcomm BAM dma driver
In-Reply-To: <1391546556-27702-2-git-send-email-agross@codeaurora.org>
References: <1391546556-27702-1-git-send-email-agross@codeaurora.org>
 <1391546556-27702-2-git-send-email-agross@codeaurora.org>
Message-ID: <1391548648.2538.32.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-02-04 at 14:42 -0600, Andy Gross wrote:
> Add the DMA engine driver for the QCOM Bus Access Manager (BAM) DMA controller
> found in the MSM 8x74 platforms.

trivia: fixable later.

> diff --git a/drivers/dma/qcom_bam_dma.c b/drivers/dma/qcom_bam_dma.c
[]
> +	/* allocate enough room to accomodate the number of entries */
> +	async_desc = kzalloc(sizeof(*async_desc) +
> +			(sg_len * sizeof(struct bam_desc_hw)), GFP_NOWAIT);
> +
> +	if (!async_desc) {
> +		dev_err(bdev->dev, "failed to allocate async descriptor\n");

Unnecessary OOM message as generic alloc has an
OOM message with a dump_stack();

> +static int bam_dma_probe(struct platform_device *pdev)
> +{
[]
> +	ret = clk_prepare_enable(bdev->bamclk);
> +	if (ret) {
> +		dev_err(bdev->dev, "failed to prepare/enable clock");

Missing terminating \n newline
