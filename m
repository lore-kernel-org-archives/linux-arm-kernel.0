From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 28 Aug 2012 20:28:30 +0530
Subject: [PATCH 0/3] ARM: EXYNOS: Add support for GPIO on Exynos4x12
In-Reply-To: <4648723.rWnut7F0uJ@amdc1227>
References: <4648723.rWnut7F0uJ@amdc1227>
Message-ID: <CAJuYYwTBeCczF7M=9pJzYUgGB3Xg1md2kRDKbYEU-ji-C1_hug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 August 2012 15:31, Tomasz Figa <t.figa@samsung.com> wrote:
> This patch series makes necessary preparations and adds support for GPIO on
> Exynos4x12 SoCs.
>
> Tomasz Figa (3):
>   ARM: EXYNOS: Use EXYNOS4210_GPEx instead of EXYNOS4_GPEx
>   gpio: samsung: Add support for Exynos4x12 SoCs
>   ARM: EXYNOS: Add support for FIMC cam port B GPIO setup on Exynos4x12
>
>  arch/arm/mach-exynos/include/mach/gpio.h   |   58 ++++--
>  arch/arm/mach-exynos/include/mach/irqs.h   |    6 -
>  arch/arm/mach-exynos/mach-nuri.c           |   16 +-
>  arch/arm/mach-exynos/mach-origen.c         |    6 +-
>  arch/arm/mach-exynos/mach-trats.c          |    4 +-
>  arch/arm/mach-exynos/mach-universal_c210.c |   32 ++--
>  arch/arm/mach-exynos/setup-fimc.c          |   21 ++-
>  drivers/gpio/gpio-samsung.c                |  351
> ++++++++++++++++++++++++----
>  8 files changed, 399 insertions(+), 95 deletions(-)
>
> --
> 1.7.8.6

Hopefully, we can get device tree support merged for Exynos4412 soon
and then switch over to using pinctrl driver. That can simplfy the
gpio/pinmux support for Exynos4 SoC's.

Thanks,
Thomas.
