From: mporter@linaro.org (Matt Porter)
Date: Fri, 25 Apr 2014 09:54:15 -0400
Subject: [PATCH] ARM: bcm: Restrict ARCH_BCM selection to ARCH_MULTI_V6_V7
In-Reply-To: <1396340779-20550-1-git-send-email-shc_work@mail.ru>
References: <1396340779-20550-1-git-send-email-shc_work@mail.ru>
Message-ID: <20140425135415.GF1127@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 01, 2014 at 12:26:19PM +0400, Alexander Shiyan wrote:
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied to mach-bcm for-3.16/soc but I added a proper commit message.
Please always have some description so we know why a patch is needed
even when it seems trivial.

Thanks,
Matt

>  arch/arm/mach-bcm/Kconfig | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index 21f97f7..1048ba1 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -1,13 +1,10 @@
>  config ARCH_BCM
> -	bool "Broadcom SoC Support"
> -	depends on ARCH_MULTIPLATFORM
> +	bool "Broadcom SoC Support" if ARCH_MULTI_V6_V7
>  	help
> -	  This enables support for Broadcom ARM based SoC
> -          chips
> -
> -if ARCH_BCM
> +	  This enables support for Broadcom ARM based SoC chips
>  
>  menu "Broadcom SoC Selection"
> +	depends on ARCH_BCM
>  
>  config ARCH_BCM_MOBILE
>  	bool "Broadcom Mobile SoC" if ARCH_MULTI_V7
> @@ -71,5 +68,3 @@ config ARCH_BCM_5301X
>  	  network SoC using a MIPS CPU, they are supported by arch/mips/bcm47xx
>  
>  endmenu
> -
> -endif
> -- 
> 1.8.3.2
> 
