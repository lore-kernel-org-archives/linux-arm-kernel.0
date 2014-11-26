From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 27 Nov 2014 02:49:01 +0900
Subject: [PATCH v2] ARM: EXYNOS: use u8 for val[] in struct exynos_pmu_conf
In-Reply-To: <1787532.9Q2MHGpzCz@amdc1032>
References: <1787532.9Q2MHGpzCz@amdc1032>
Message-ID: <5476128D.6070400@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/14 02:21, Bartlomiej Zolnierkiewicz wrote:
> Values stored in val[] are never bigger than a byte.
> 
>    text    data     bss     dec     hex filename
>    7716    3692       8   11416    2c98 arch/arm/mach-exynos/pmu.o.before
>    5436    1908       8    7352    1cb8 arch/arm/mach-exynos/pmu.o.after
> 
> Cc: Pankaj Dubey <pankaj.dubey@samsung.com>
> Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> v2:
> - rebased on top of next-20141126 branch of linux-next kernel tree
>   (it also applies fine to for-next branch of linux-samsung.git)
> 
>  arch/arm/mach-exynos/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
> index ccb0120..c15761c 100644
> --- a/arch/arm/mach-exynos/pmu.c
> +++ b/arch/arm/mach-exynos/pmu.c
> @@ -25,7 +25,7 @@
>  
>  struct exynos_pmu_conf {
>  	unsigned int offset;
> -	unsigned int val[NUM_SYS_POWERDOWN];
> +	u8 val[NUM_SYS_POWERDOWN];
>  };
>  
>  struct exynos_pmu_data {

Applied, thanks.

- Kukjin
