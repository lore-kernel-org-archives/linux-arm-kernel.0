From: mbrugger@suse.com (Matthias Brugger)
Date: Fri, 28 Oct 2016 18:38:51 +0200
Subject: [PATCH] fpga: zynq-fpga: Delete not needed variable
In-Reply-To: <20161028112722.22837-1-mbrugger@suse.com>
References: <20161028112722.22837-1-mbrugger@suse.com>
Message-ID: <a840247c-e1ad-e789-7947-3b499c887dec@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28/10/16 13:27, Matthias Brugger wrote:
> Variable count is never changed in the write path,
> we don't need to save it for freeing the dma memory.
>
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>

This is obsolete, as Jason already has this in his patch [1].
Sorry for the noise.

[1] http://www.spinics.net/lists/arm-kernel/msg538868.html

> ---
>  drivers/fpga/zynq-fpga.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index c2fb412..ffc2823 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -287,12 +287,10 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr,
>  	struct zynq_fpga_priv *priv;
>  	int err;
>  	char *kbuf;
> -	size_t in_count;
>  	dma_addr_t dma_addr;
>  	u32 transfer_length;
>  	u32 intr_status;
>
> -	in_count = count;
>  	priv = mgr->priv;
>
>  	kbuf = dma_alloc_coherent(priv->dev, count, &dma_addr, GFP_KERNEL);
> @@ -338,7 +336,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr,
>  	clk_disable(priv->clk);
>
>  out_free:
> -	dma_free_coherent(priv->dev, in_count, kbuf, dma_addr);
> +	dma_free_coherent(priv->dev, count, kbuf, dma_addr);
>
>  	return err;
>  }
>
