From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 22 Oct 2012 08:50:01 +0900
Subject: [PATCH] ARM: EXYNOS: exynos4-dt: Set .smp field of machine
 descriptor
In-Reply-To: <1350035378-31989-1-git-send-email-t.figa@samsung.com>
References: <1350035378-31989-1-git-send-email-t.figa@samsung.com>
Message-ID: <04c801cdafe6$c96e2470$5c4a6d50$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> This patch adds missing initializer of .smp field of machine descriptor
> of Exynos 4 DT machine.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  arch/arm/mach-exynos/mach-exynos4-dt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-
> exynos/mach-exynos4-dt.c
> index 7222e3c..d6bdcfb 100644
> --- a/arch/arm/mach-exynos/mach-exynos4-dt.c
> +++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
> @@ -119,6 +119,7 @@ static char const *exynos4_dt_compat[] __initdata = {
> 
>  DT_MACHINE_START(EXYNOS4210_DT, "Samsung Exynos4 (Flattened Device
Tree)")
>  	/* Maintainer: Thomas Abraham <thomas.abraham@linaro.org> */
> +	.smp		= smp_ops(exynos_smp_ops),
>  	.init_irq	= exynos4_init_irq,
>  	.map_io		= exynos4_dt_map_io,
>  	.handle_irq	= gic_handle_irq,
> --
> 1.7.12

Yes, right. Applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
