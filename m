From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 16 Jul 2014 13:59:32 +0200
Subject: [PATCH v2] ARM: EXYNOS: Fix build with PM_SLEEP=n
In-Reply-To: <1405323953-25954-1-git-send-email-k.kozlowski@samsung.com>
References: <1405323953-25954-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <53C66924.3010303@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 14.07.2014 09:45, Krzysztof Kozlowski wrote:
> Fix building of exynos defconfig with disabled PM_SLEEP:
> CONFIG_PM_SLEEP=n
> CONFIG_PM_SLEEP_SMP=n
> CONFIG_SUSPEND=n
> by moving functions for power up/down of CPU and cluster to platsmp.c
> 
> The build error messages:
> arch/arm/mach-exynos/built-in.o: In function `exynos_boot_secondary':
> arch/arm/mach-exynos/platsmp.c:111: undefined reference to `exynos_cpu_power_state'
> arch/arm/mach-exynos/platsmp.c:112: undefined reference to `exynos_cpu_power_up'
> arch/arm/mach-exynos/platsmp.c:116: undefined reference to `exynos_cpu_power_state'
> make: *** [vmlinux] Error 1
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> ---
> Changes since v1:
> 1. Use different solution - just move the power up/down functions to a
>    common place instead of adding stubs in common.h. Suggested by Tomasz
>    Figa.
> ---
>  arch/arm/mach-exynos/platsmp.c | 66 ++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-exynos/pm.c      | 66 ------------------------------------------
>  2 files changed, 66 insertions(+), 66 deletions(-)
> 

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

--
Best regards,
Tomasz
