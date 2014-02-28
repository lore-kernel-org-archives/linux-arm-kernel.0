From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 27 Feb 2014 19:27:03 -0500
Subject: [PATCH] dma: of: Move the functions under CONFIG_OF_DMA instead
 of CONFIG_OF
In-Reply-To: <1393546850-13907-1-git-send-email-santosh.shilimkar@ti.com>
References: <1393546850-13907-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <530FD7D7.9000104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 February 2014 07:20 PM, Santosh Shilimkar wrote:
> The of-dma.c is compiled out with !CONFIG_OF_DMA but the functions in
> the header are kept under CONFIG_OF. Move them under CONFIG_OF_DMA
> to avoid build errors with CONFIG_OFF && !CONFIG_OF_DMA
> 
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  include/linux/of_dma.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
> index 0322363..3d2beab 100644
> --- a/include/linux/of_dma.h
> +++ b/include/linux/of_dma.h
> @@ -31,7 +31,7 @@ struct of_dma_filter_info {
>  	dma_filter_fn	filter_fn;
>  };
>  
> -#ifdef CONFIG_OF
> +#ifdef CONFIG_OF_DMA
Sorry.. Typo here.. Should have been CONFIG_DMA_OF

>From 31242461b6ba5e8c0c5ee26e394fa4cab61e3aa1 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Thu, 27 Feb 2014 19:13:36 -0500
Subject: [PATCH] dma: of: Move the functions under CONFIG_DMA_OF instead of
 CONFIG_OF

The of-dma.c is compiled out with !CONFIG_DMA_OF but the functions in
the header are kept under CONFIG_OF. Move them under CONFIG_OF_DMA
to avoid build errors with CONFIG_OFF && !CONFIG_DMA_OF

Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 include/linux/of_dma.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
index 0322363..0ea24f4 100644
--- a/include/linux/of_dma.h
+++ b/include/linux/of_dma.h
@@ -31,7 +31,7 @@ struct of_dma_filter_info {
 	dma_filter_fn	filter_fn;
 };
 
-#ifdef CONFIG_OF
+#ifdef CONFIG_DMA_OF
 extern int of_dma_controller_register(struct device_node *np,
 		struct dma_chan *(*of_dma_xlate)
 		(struct of_phandle_args *, struct of_dma *),
-- 
1.7.9.5
