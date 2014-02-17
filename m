From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 17 Feb 2014 08:40:43 +0530
Subject: [PATCH v3 1/3] ARM: EXYNOS: initial board support for exynos5260
 SoC
In-Reply-To: <1392385032-22015-2-git-send-email-rahul.sharma@samsung.com>
References: <1392385032-22015-1-git-send-email-rahul.sharma@samsung.com>
 <1392385032-22015-2-git-send-email-rahul.sharma@samsung.com>
Message-ID: <CAK9yfHyb7ij0soCmrJvw9OrW2mKdY1QBpnqLdzeRHqdvOGN61g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rahul,

On 14 February 2014 19:07, Rahul Sharma <rahul.sharma@samsung.com> wrote:
> From: Pankaj Dubey <pankaj.dubey@samsung.com>
>
> This patch add basic arch side support for exynos5260 SoC.
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
> ---
>  arch/arm/mach-exynos/Kconfig             |    9 +++++++++
>  arch/arm/mach-exynos/common.c            |   11 +++++++++++
>  arch/arm/mach-exynos/include/mach/map.h  |    1 +
>  arch/arm/mach-exynos/mach-exynos5-dt.c   |    1 +
>  arch/arm/plat-samsung/include/plat/cpu.h |    8 ++++++++
>  5 files changed, 30 insertions(+)
>
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index 4c414af..5c96248 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -91,6 +91,15 @@ config SOC_EXYNOS5250
>         help
>           Enable EXYNOS5250 SoC support
>
> +config SOC_EXYNOS5260
> +       bool "SAMSUNG EXYNOS5260"
> +       default y
> +       depends on ARCH_EXYNOS5
> +       select AUTO_ZRELADDR
> +       select SAMSUNG_DMADEV
> +       help
> +         Enable EXYNOS5260 SoC support
> +

Per SoC entries are no longer needed with the patch at [1].

[1] http://www.spinics.net/lists/linux-samsung-soc/msg26253.html

-- 
With warm regards,
Sachin
