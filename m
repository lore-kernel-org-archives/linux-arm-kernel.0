From: sanjay.rawat@linaro.org (Sanjay Singh Rawat)
Date: Tue, 04 Jun 2013 20:55:19 +0530
Subject: [PATCH 1/8] ARM: EXYNOS: use generic cpu idle function for wfi
In-Reply-To: <1369665166-13049-2-git-send-email-sanjay.rawat@linaro.org>
References: <1369665166-13049-1-git-send-email-sanjay.rawat@linaro.org>
 <1369665166-13049-2-git-send-email-sanjay.rawat@linaro.org>
Message-ID: <51AE06DF.1000407@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kukjin,

can you please review the patch?

On Monday 27 May 2013 08:02 PM, Sanjay Singh Rawat wrote:
> use cpu_do_idle for entering the WFI mode.
>
> Signed-off-by: Sanjay Singh Rawat<sanjay.rawat@linaro.org>
> ---
>   arch/arm/mach-exynos/hotplug.c |    9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
> index af90cfa..7fcedd8 100644
> --- a/arch/arm/mach-exynos/hotplug.c
> +++ b/arch/arm/mach-exynos/hotplug.c
> @@ -98,13 +98,8 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
>   		if (cpu == 1)
>   			__raw_writel(0, S5P_ARM_CORE1_CONFIGURATION);
>
> -		/*
> -		 * here's the WFI
> -		 */
> -		asm(".word	0xe320f003\n"
> -		    :
> -		    :
> -		    : "memory", "cc");
> +		/* enter WFI mode */
> +		cpu_do_idle();
>
>   		if (pen_release == cpu_logical_map(cpu)) {
>   			/*
