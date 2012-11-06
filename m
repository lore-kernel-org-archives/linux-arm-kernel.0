From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 06 Nov 2012 20:43:08 +0900
Subject: [PATCH] ARM: Exynos: remove unused init_uarts callback for
 exynos4x12 platforms
In-Reply-To: <1352125973-24228-1-git-send-email-thomas.abraham@linaro.org>
References: <1352125973-24228-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <0bf001cdbc13$e4816c20$ad844460$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote:
> 
> All the Exynos4x12 based platforms use only device tree based boot. So
> remove
> the unused 'init_uarts' callback from exynos cpu_ids table.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  arch/arm/mach-exynos/common.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
> index 56844d1..ce91cba 100644
> --- a/arch/arm/mach-exynos/common.c
> +++ b/arch/arm/mach-exynos/common.c
> @@ -78,7 +78,6 @@ static struct cpu_table cpu_ids[] __initdata = {
>  		.idmask		= EXYNOS4_CPU_MASK,
>  		.map_io		= exynos4_map_io,
>  		.init_clocks	= exynos4_init_clocks,
> -		.init_uarts	= exynos_init_uarts,
>  		.init		= exynos_init,
>  		.name		= name_exynos4212,
>  	}, {
> @@ -86,7 +85,6 @@ static struct cpu_table cpu_ids[] __initdata = {
>  		.idmask		= EXYNOS4_CPU_MASK,
>  		.map_io		= exynos4_map_io,
>  		.init_clocks	= exynos4_init_clocks,
> -		.init_uarts	= exynos_init_uarts,
>  		.init		= exynos_init,
>  		.name		= name_exynos4412,
>  	}, {
> --
> 1.6.6.rc2

Yes, correct. Applied.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
