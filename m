From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 16 Apr 2014 16:35:03 +0200
Subject: [PATCHv2 6/8] ARM: EXYNOS: Enter a15 lowpower mode for Exynos3250
 based on Cortex-a7
In-Reply-To: <1397527192-21988-7-git-send-email-cw00.choi@samsung.com>
References: <1397527192-21988-1-git-send-email-cw00.choi@samsung.com>
 <1397527192-21988-7-git-send-email-cw00.choi@samsung.com>
Message-ID: <534E9517.2040409@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

On 15.04.2014 03:59, Chanwoo Choi wrote:
> This patch decide proper lowpower mode of either a15 or a9 according to own ID
> from Main ID register.
>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>   arch/arm/mach-exynos/hotplug.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
> index 5eead53..99e54e0 100644
> --- a/arch/arm/mach-exynos/hotplug.c
> +++ b/arch/arm/mach-exynos/hotplug.c
> @@ -135,16 +135,22 @@ void __ref exynos_cpu_die(unsigned int cpu)
>   	int primary_part = 0;
>
>   	/*
> -	 * we're ready for shutdown now, so do it.
> -	 * Exynos4 is A9 based while Exynos5 is A15; check the CPU part
> +	 * we're ready for shutdown now, so do it. Exynos4 is A9 based
> +	 * while Exynos5 is A15/Exynos3 is A7; check the CPU part
>   	 * number by reading the Main ID register and then perform the
>   	 * appropriate sequence for entering low power.

If changing this comment anyway, I'd suggest removing particular SoC 
series from it and also correct writing style. My suggestion is:

/*
  * Prepare the CPU for shutting down. The required sequence of
  * operations depends on core type. CPUID part number can be used to
  * determine the right way.
  */

Best regards,
Tomasz
