From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 6 Jul 2012 20:21:42 +0800
Subject: [PATCH] ARM: dma: mxs-dma: Export missing symbols from mxs-dma.c
In-Reply-To: <1341573766-12459-1-git-send-email-attila@kinali.ch>
References: <20120706111020.GD12558@shlinux2.ap.freescale.net>
 <1341573766-12459-1-git-send-email-attila@kinali.ch>
Message-ID: <20120706122141.GE22133@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only the patch touching files under arch/arm/ should have "ARM:" in
the patch subject.  So you need to drop it from there.

-- 
Regards,
Shawn

On Fri, Jul 06, 2012 at 01:22:46PM +0200, Attila Kinali wrote:
> mxs-dma.c provides two functions mxs_dma_is_apbh and mxs_dma_is_apbx
> which are used at least in mxs-mmc.c. Building mxs-mmc as module
> fails due to those two symbols not being exported.
> 
> Signed-off-by: Attila Kinali <attila@kinali.ch>
> ---
>  drivers/dma/mxs-dma.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
> index c96ab15..96d8b80 100644
> --- a/drivers/dma/mxs-dma.c
> +++ b/drivers/dma/mxs-dma.c
> @@ -201,6 +201,7 @@ int mxs_dma_is_apbh(struct dma_chan *chan)
>  
>  	return dma_is_apbh(mxs_dma);
>  }
> +EXPORT_SYMBOL_GPL(mxs_dma_is_apbh);
>  
>  int mxs_dma_is_apbx(struct dma_chan *chan)
>  {
> @@ -209,6 +210,7 @@ int mxs_dma_is_apbx(struct dma_chan *chan)
>  
>  	return !dma_is_apbh(mxs_dma);
>  }
> +EXPORT_SYMBOL_GPL(mxs_dma_is_apbx);
>  
>  static void mxs_dma_reset_chan(struct mxs_dma_chan *mxs_chan)
>  {
> -- 
> 1.7.10
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
