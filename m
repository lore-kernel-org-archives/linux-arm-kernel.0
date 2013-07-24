From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 24 Jul 2013 14:15:34 +0900
Subject: [PATCH V2 2/2] ARM: EXYNOS: cpuidle: Allow C1 state only in
 supported SOC's.
In-Reply-To: <1371036526-16589-3-git-send-email-amit.daniel@samsung.com>
References: <1371036526-16589-1-git-send-email-amit.daniel@samsung.com>
 <1371036526-16589-3-git-send-email-amit.daniel@samsung.com>
Message-ID: <0e2301ce882c$d39021a0$7ab064e0$@org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amit Daniel Kachhap wrote:
> 
> This patch registers the basic C0 state for all exynos SOC's but
> limits the C1(AFTR -Arm off top running) state in only the supported
> SOC's(ie. EXYNOS 4210, 4212, 4412 and 5250).
> 
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
>  arch/arm/mach-exynos/cpuidle.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-
> exynos/cpuidle.c
> index 2d071c6..ccb2b48 100644
> --- a/arch/arm/mach-exynos/cpuidle.c
> +++ b/arch/arm/mach-exynos/cpuidle.c
> @@ -176,7 +176,9 @@ static int __init exynos4_init_cpuidle(void)
>  		device->cpu = cpu_id;
> 
>  		/* Support IDLE only */
> -		if (cpu_id != 0)
> +		if (!(soc_is_exynos4210() || soc_is_exynos4212() ||
> +			soc_is_exynos4412() || soc_is_exynos5250()) ||
> +			cpu_id != 0)

How about exynos5420?

So...

+		if (soc_is_exynos5440() || cpu_id !=0) ?

>  			device->state_count = 1;
> 
>  		ret = cpuidle_register_device(device);
> --
> 1.7.1

- Kukjin
