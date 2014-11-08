From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 08 Nov 2014 18:50:04 +0900
Subject: [PATCH] ARM: exynos_defconfig: disable CONFIG_EXYNOS5420_MCPM; not
 stable
In-Reply-To: <1414796382-5447-1-git-send-email-khilman@kernel.org>
References: <1414796382-5447-1-git-send-email-khilman@kernel.org>
Message-ID: <000e01cffb39$5ef0a2d0$1cd1e870$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman wrote:
> 
> From: Kevin Hilman <khilman@linaro.org>
> 
> The option CONFIG_EXYNOS5420_MCPM is causing imprecise external aborts
> during boot testing, causing various userspace startup failures.
> 
> Disable until it has gotten more testing.
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>,
> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
> Cc: Sachin Kamat <sachin.kamat@samsung.com>,
> Cc: Doug Anderson <dianders@chromium.org>,
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
> Cc: Tushar Behera <tushar.behera@linaro.org>,
> Cc: stable at vger.kernel.org # v3.17+
> Signed-off-by: Kevin Hilman <khilman@linaro.org>
> ---
> This has been reported by a few people[1], but not investigated or fixed, so it's
> time to disable this feature until it can be fixed.
> 
Hi Kevin,

Yeah I agree with your opinion.

But as you can see my tree, I've queued regarding mcpm patches for 3.19 will
be shown in -next in this weekend. Anyway let me apply this into -fixes and
then let's enable after test its functionality in -next in a couple of days.

Thanks,
Kukjin


> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/288344.html
> 
>  arch/arm/configs/exynos_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 72058b8a6f4d..a250dcbf34cd 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -10,7 +10,7 @@ CONFIG_MODULE_UNLOAD=y
>  CONFIG_PARTITION_ADVANCED=y
>  CONFIG_ARCH_EXYNOS=y
>  CONFIG_ARCH_EXYNOS3=y
> -CONFIG_EXYNOS5420_MCPM=y
> +CONFIG_EXYNOS5420_MCPM=n
>  CONFIG_SMP=y
>  CONFIG_BIG_LITTLE=y
>  CONFIG_BL_SWITCHER=y
> --
> 2.1.0
