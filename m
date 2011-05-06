From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 06 May 2011 14:19:51 +0900
Subject: [PATCH] ARM: EXYNOS4: Add to support ORIGEN board
In-Reply-To: <1303796228-9729-1-git-send-email-snow.jhkim@gmail.com>
References: <1303796228-9729-1-git-send-email-snow.jhkim@gmail.com>
Message-ID: <00fd01cc0bad$3b961100$b2c23300$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

JeongHyeon Kim wrote:
> 
> From: JeongHyeon Kim <jhkim@insignal.co.kr>
> 
> This patch adds to support Insignal's ORIGEN board.
> 
> Signed-off-by: JeongHyeon Kim <jhkim@insignal.co.kr>
> ---
>  arch/arm/mach-exynos4/Kconfig       |   10 +++
>  arch/arm/mach-exynos4/Makefile      |    1 +
>  arch/arm/mach-exynos4/mach-origen.c |  108
> +++++++++++++++++++++++++++++++++++
>  3 files changed, 119 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-exynos4/mach-origen.c
> 
Hi Jeonghyeon,

Basically, adding board file cannot be merged(applied) into regarding ARM
maintainer tree now even though your patch has no problem. You can easily
find the reason when you read some threads in here.

So I'm not sure when your patch can be merged.

There is comment. But no need to re-submit, if required, I can fix it when I
apply this.

> diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
> index e849f67..0a61cf3 100644
> --- a/arch/arm/mach-exynos4/Kconfig
> +++ b/arch/arm/mach-exynos4/Kconfig
> @@ -177,6 +177,16 @@ config MACH_NURI
>  	help
>  	  Machine support for Samsung Mobile NURI Board.
> 
> +config MACH_ORIGEN
> +        bool "ORIGEN"
   ^^^^^^^^
> +        select CPU_EXYNOS4210
   ^^^^^^^^
> +        select S3C_DEV_RTC
   ^^^^^^^^
> +        select S3C_DEV_WDT
   ^^^^^^^^
> +        select S3C_DEV_HSMMC2
   ^^^^^^^^
> +        select EXYNOS4_SETUP_SDHCI
   ^^^^^^^^
> +        help
   ^^^^^^^^
> +          Machine support for ORIGEN based on Samsung S5PV310
   ^^^^^^^^

Should be tab...

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
