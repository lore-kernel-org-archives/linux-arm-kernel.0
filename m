From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 28 Sep 2018 15:54:06 +0200
Subject: [PATCH] ARM: SAMSUNG: limit SAMSUNG_PM_DEBUG config option to
 non-Exynos platforms
In-Reply-To: <20180928133713eucas1p16a15a68b61de9aa3310737f7fd77d20d~Yk9kqY_Ga2124121241eucas1p1b@eucas1p1.samsung.com>
References: <CGME20180928133713eucas1p16a15a68b61de9aa3310737f7fd77d20d@eucas1p1.samsung.com>
 <20180928133713eucas1p16a15a68b61de9aa3310737f7fd77d20d~Yk9kqY_Ga2124121241eucas1p1b@eucas1p1.samsung.com>
Message-ID: <CAJKOXPcfvpiO8NpRzDwNgEyJf21+jFt8r9E=OOs_6f7wSjC+Zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Sep 2018 at 15:37, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> "Samsung PM Suspend debug" feature (controlled by SAMSUNG_PM_DEBUG
> config option) is not working properly (debug messages are not
> displayed after resume) on Exynos platforms because GPIOs restore
> code is not implemented.

AFAIR, it worked properly for the suspend part showing more logs.
Unless it changed, the feature looks still useful.

Best regards,
Krzysztof

>
> Add PLAT_S3C24XX, ARCH_S3C64XX and ARCH_S5PV210 dependencies to
> SAMSUNG_PM_DEBUG config option to hide it on Exynos platforms.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/plat-samsung/Kconfig |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Index: b/arch/arm/plat-samsung/Kconfig
> ===================================================================
> --- a/arch/arm/plat-samsung/Kconfig     2018-09-28 15:20:06.041911426 +0200
> +++ b/arch/arm/plat-samsung/Kconfig     2018-09-28 15:20:06.037911426 +0200
> @@ -238,7 +238,8 @@ comment "Power management"
>
>  config SAMSUNG_PM_DEBUG
>         bool "Samsung PM Suspend debug"
> -       depends on PM && DEBUG_KERNEL
> +       depends on DEBUG_KERNEL
> +       depends on PM && (PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210)
>         depends on DEBUG_EXYNOS_UART || DEBUG_S3C24XX_UART || DEBUG_S3C2410_UART
>         help
>           Say Y here if you want verbose debugging from the PM Suspend and
>
