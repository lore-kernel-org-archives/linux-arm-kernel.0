From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Feb 2013 14:55:58 -0800
Subject: [PATCH 7/9] remoteproc: omap: depend on OMAP_MBOX_FWK
In-Reply-To: <1360882071-4072668-8-git-send-email-arnd@arndb.de>
References: <1360882071-4072668-1-git-send-email-arnd@arndb.de>
 <1360882071-4072668-8-git-send-email-arnd@arndb.de>
Message-ID: <20130214225557.GI11362@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [130214 14:51]:
> Patch a62a6e98 "ARM: OMAP2+: Disable code that currently does not work
> with multiplaform" makes the OMAP_MBOX_FWK option depend on !MULTIPLATFORM,
> which means we cannot simply select that symbol from OMAP_REMOTEPROC.
> 
> Turning the 'select' into 'depends on' ensures that all dependencies
> are correct until OMAP_MBOX_FWK loses its dependency.
> 
> Without this patch, building allmodconfig results in:
> 
> drivers/remoteproc/omap_remoteproc.c:31:26: fatal error: plat/mailbox.h: No such file or directory
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Tony Lindgren <tony@atomide.com>

> Cc: Ohad Ben-Cohen <ohad@wizery.com>
> ---
>  drivers/remoteproc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 0b24108..cc1f7bf 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -12,8 +12,8 @@ config OMAP_REMOTEPROC
>  	depends on HAS_DMA
>  	depends on ARCH_OMAP4
>  	depends on OMAP_IOMMU
> +	depends on OMAP_MBOX_FWK
>  	select REMOTEPROC
> -	select OMAP_MBOX_FWK
>  	select RPMSG
>  	help
>  	  Say y here to support OMAP's remote processors (dual M3
> -- 
> 1.8.1.2
> 
