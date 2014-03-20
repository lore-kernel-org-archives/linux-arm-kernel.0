From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 Mar 2014 13:13:37 +0900
Subject: [PATCH 53/62] ARM: samsung: fix SAMSUNG_PM_DEBUG Kconfig logic
In-Reply-To: <1395257399-359545-54-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-54-git-send-email-arnd@arndb.de>
Message-ID: <022401cf43f2$c4564b10$4d02e130$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> The suspend debug code for Samsung has multiple dependencies
> that we should not unconditionally enable. In particular,
> we rely on the DEBUG_S3C_UART setting, which in turn depends
> on the samsung UART driver.
> 
> Signed-off-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>

Yes, right.

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks,
Kukjin

> Cc: Ben Dooks <ben-linux@fluff.org>
> ---
>  arch/arm/plat-samsung/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> index 04974db..c72d612 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -428,8 +428,7 @@ comment "Power management"
> 
>  config SAMSUNG_PM_DEBUG
>  	bool "S3C2410 PM Suspend debug"
> -	depends on PM
> -	select DEBUG_LL
> +	depends on PM && DEBUG_KERNEL && DEBUG_S3C_UART
>  	help
>  	  Say Y here if you want verbose debugging from the PM Suspend and
>  	  Resume code. See <file:Documentation/arm/Samsung-
> S3C24XX/Suspend.txt>
> --
> 1.8.3.2
