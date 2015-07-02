From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 2 Jul 2015 13:15:21 +0200
Subject: [PATCH v3 3/4] ARM: Exynos: switch to using generic cpufreq
 driver for Exynos5250
In-Reply-To: <1435756238-845-4-git-send-email-b.zolnierkie@samsung.com>
References: <1435756238-845-1-git-send-email-b.zolnierkie@samsung.com>
 <1435756238-845-4-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <CABxcv==_B_e6Tm6vGG9kPPqyL97RTsHUv6oH19xd8ZkecgyA_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 1, 2015 at 3:10 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
>
> The new CPU clock type allows the use of generic CPUfreq driver.
> Switch Exynos5250 to using generic cpufreq driver.
>
> Changes by Bartlomiej:
> - split Exynos5250 support from the original patch
>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index 5f8ddcd..4015ec3 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -226,6 +226,7 @@ static void __init exynos_init_irq(void)
>
>  static const struct of_device_id exynos_cpufreq_matches[] = {
>         { .compatible = "samsung,exynos4210", .data = "cpufreq-dt" },
> +       { .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
>         { /* sentinel */ }
>  };

Reviewed-by: Javier Martinez Canillas <javier@dowhile0.org>

and on an Exynos5250 Snow Chromebook:

Tested-by: Javier Martinez Canillas <javier@dowhile0.org>

Best regards,
Javier
