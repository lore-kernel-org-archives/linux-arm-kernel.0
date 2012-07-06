From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 6 Jul 2012 18:52:53 +0800
Subject: [PATCH] ARM: mxs: Export missing symbols from mxs-dma.c
In-Reply-To: <1341565366-11441-1-git-send-email-attila@kinali.ch>
References: <1341565366-11441-1-git-send-email-attila@kinali.ch>
Message-ID: <20120706105252.GC12558@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2012 at 11:02:46AM +0200, Attila Kinali wrote:
> mxs-dma.c provides two functions mxs_dma_is_apbh and mxs_dma_is_apbx
> which are used at least in mxs-mmc.c. Building mxs-mmc as module
> fails due to those two symbols not being exported.
> 
> Signed-off-by: Attila Kinali <attila@kinali.ch>
> ---
>  drivers/dma/mxs-dma.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
> index c96ab15..4ea1909 100644
> --- a/drivers/dma/mxs-dma.c
> +++ b/drivers/dma/mxs-dma.c
> @@ -779,3 +779,6 @@ static int __init mxs_dma_module_init(void)
>  	return platform_driver_probe(&mxs_dma_driver, mxs_dma_probe);
>  }
>  subsys_initcall(mxs_dma_module_init);
> +
> +EXPORT_SYMBOL(mxs_dma_is_apbh);
> +EXPORT_SYMBOL(mxs_dma_is_apbx);
If i understand correctly, usually we add EXPORT_SYMBOL right below the function
exported.
And can we use EXPORT_SYMBOL_GPL?
It seems both driver using this are gpl licensed.

BTW, maybe you also need change the patch title format a bit:
dma: mxs-dma: ...

Regards
Dong Aisheng
