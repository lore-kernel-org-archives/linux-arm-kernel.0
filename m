From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 02 Apr 2012 11:57:56 -0700
Subject: [PATCH] mach-exynos: fix ISO C90 warning.
In-Reply-To: <1333367732-28014-1-git-send-email-corone.il.han@gmail.com>
References: <1333367732-28014-1-git-send-email-corone.il.han@gmail.com>
Message-ID: <4F79F6B4.9080005@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il Han wrote:
> ISO C90 forbids mixed declarations and code.
> Fix it.
> 
> Signed-off-by: Il Han<corone.il.han@gmail.com>
> ---
>   arch/arm/mach-exynos/common.c |    3 ++-
>   1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
> index e6cc50e..8614aab 100644
> --- a/arch/arm/mach-exynos/common.c
> +++ b/arch/arm/mach-exynos/common.c
> @@ -583,10 +583,11 @@ core_initcall(exynos_core_init);
>   #ifdef CONFIG_CACHE_L2X0
>   static int __init exynos4_l2x0_cache_init(void)
>   {
> +	int ret;
> +
>   	if (soc_is_exynos5250())
>   		return 0;
> 
> -	int ret;
>   	ret = l2x0_of_init(L2_AUX_VAL, L2_AUX_MASK);
>   	if (!ret) {
>   		l2x0_regs_phys = virt_to_phys(&l2x0_saved_regs);

Yeah, seems happened wehn merge confilcts resolved.

OK, will apply and if possible, please use following subject form in
next time like others. Every ARM platfomrs use that.

'ARM: EXYNOS: ...'

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
