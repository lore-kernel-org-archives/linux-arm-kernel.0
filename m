From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 01 Feb 2016 10:26:32 +0900
Subject: [PATCH 6/6] ARM: exynos: select THERMAL_OF
In-Reply-To: <1454079040-3567945-7-git-send-email-arnd@arndb.de>
References: <1454079040-3567945-1-git-send-email-arnd@arndb.de>
 <1454079040-3567945-7-git-send-email-arnd@arndb.de>
Message-ID: <56AEB448.1080108@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.01.2016 23:50, Arnd Bergmann wrote:
> We cannot select a symbol that has disabled dependencies, so
> we get a warning if we ever enable EXYNOS_THERMAL without
> also turning on THERMAL_OF:
> 
> warning: (ARCH_EXYNOS) selects EXYNOS_THERMAL which has unmet direct dependencies (THERMAL && (ARCH_EXYNOS || COMPILE_TEST) && THERMAL_OF)
> 
> This adds another 'select' in the platform code to avoid that
> case. Alternatively, we could decide to not select EXYNOS_THERMAL
> here and instead make it a user option.

We want EXYNOS_THERMAL because we are using boost cpufreq on Exynos4x12
(through turbo frequencies in DTS and cpufreq-dt) so your current
solution is a proper fix for:

Fixes: f87e6bd3f740 ("thermal: exynos: Add the dependency of
CONFIG_THERMAL_OF instead of CONFIG_OF")

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>


Best regards,
Krzysztof

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-exynos/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index 652a0bb11578..5189bcecad12 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -27,6 +27,7 @@ menuconfig ARCH_EXYNOS
>  	select S5P_DEV_MFC
>  	select SRAM
>  	select THERMAL
> +	select THERMAL_OF
>  	select MFD_SYSCON
>  	select CLKSRC_EXYNOS_MCT
>  	select POWER_RESET
> 
