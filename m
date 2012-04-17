From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 17 Apr 2012 15:31:09 +0900
Subject: [PATCH 07/12] ARM: Exynos5: Modify the GIC physical address for
 static io-mapping
In-Reply-To: <1334641595-25301-8-git-send-email-thomas.abraham@linaro.org>
References: <1334641595-25301-1-git-send-email-thomas.abraham@linaro.org>
 <1334641595-25301-8-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CAH9JG2Wxz3a5O-a-MfnPZph6HjdSSpVzzhkbCcsZQRaXebWZBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 4/17/12, Thomas Abraham <thomas.abraham@linaro.org> wrote:
> From: Changhwan Youn <chaos.youn@samsung.com>
>
> Adapt to changes in GIC physical address in rev1 of Exynos5.

Does it different from rev0 and rev1? and does it support the rev1 only?

Thank you,
Kyungmin Park
>
> Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
> ---
>  arch/arm/mach-exynos/common.c           |    4 ++--
>  arch/arm/mach-exynos/include/mach/map.h |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
> index 35ac675..457d031 100644
> --- a/arch/arm/mach-exynos/common.c
> +++ b/arch/arm/mach-exynos/common.c
> @@ -265,12 +265,12 @@ static struct map_desc exynos5_iodesc[] __initdata = {
>  	}, {
>  		.virtual	= (unsigned long)S5P_VA_GIC_CPU,
>  		.pfn		= __phys_to_pfn(EXYNOS5_PA_GIC_CPU),
> -		.length		= SZ_64K,
> +		.length		= SZ_8K,
>  		.type		= MT_DEVICE,
>  	}, {
>  		.virtual	= (unsigned long)S5P_VA_GIC_DIST,
>  		.pfn		= __phys_to_pfn(EXYNOS5_PA_GIC_DIST),
> -		.length		= SZ_64K,
> +		.length		= SZ_4K,
>  		.type		= MT_DEVICE,
>  	},
>  };
> diff --git a/arch/arm/mach-exynos/include/mach/map.h
> b/arch/arm/mach-exynos/include/mach/map.h
> index 0e2292d..648d59b 100644
> --- a/arch/arm/mach-exynos/include/mach/map.h
> +++ b/arch/arm/mach-exynos/include/mach/map.h
> @@ -78,8 +78,8 @@
>
>  #define EXYNOS4_PA_GIC_CPU		0x10480000
>  #define EXYNOS4_PA_GIC_DIST		0x10490000
> -#define EXYNOS5_PA_GIC_CPU		0x10480000
> -#define EXYNOS5_PA_GIC_DIST		0x10490000
> +#define EXYNOS5_PA_GIC_CPU		0x10482000
> +#define EXYNOS5_PA_GIC_DIST		0x10481000
>
>  #define EXYNOS4_PA_COREPERI		0x10500000
>  #define EXYNOS4_PA_TWD			0x10500600
> --
> 1.6.6.rc2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
