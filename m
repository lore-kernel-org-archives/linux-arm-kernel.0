From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 02 Dec 2011 18:01:40 +0900
Subject: [PATCH 1/4] ARM: EXYNOS4: Add DMC1, allow PPMU access for DMC.
In-Reply-To: <1322730317-8171-2-git-send-email-myungjoo.ham@samsung.com>
References: <1322730317-8171-1-git-send-email-myungjoo.ham@samsung.com>
 <1322730317-8171-2-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <04fb01ccb0d1$016ebdf0$044c39d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> - Add DMC1
> - Enlarge address space for DMC from 4k to 64k so that PPMU registers
>   may be accessed.
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos/cpu.c              |    7 ++++++-
>  arch/arm/mach-exynos/include/mach/map.h |    1 +
>  2 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/cpu.c b/arch/arm/mach-exynos/cpu.c
> index 90ec247..8bdcba9 100644
> --- a/arch/arm/mach-exynos/cpu.c
> +++ b/arch/arm/mach-exynos/cpu.c
> @@ -108,7 +108,12 @@ static struct map_desc exynos4_iodesc[] __initdata =
> {
>  	}, {
>  		.virtual	= (unsigned long)S5P_VA_DMC0,
>  		.pfn		= __phys_to_pfn(EXYNOS4_PA_DMC0),
> -		.length		= SZ_4K,
> +		.length		= SZ_64K,
> +		.type		= MT_DEVICE,
> +	}, {
> +		.virtual	= (unsigned long)S5P_VA_DMC1,
> +		.pfn		= __phys_to_pfn(EXYNOS4_PA_DMC1),
> +		.length		= SZ_64K,
>  		.type		= MT_DEVICE,
>  	}, {
>  		.virtual	= (unsigned long)S5P_VA_SROMC,
> diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-
> exynos/include/mach/map.h
> index 058541d..870a980 100644
> --- a/arch/arm/mach-exynos/include/mach/map.h
> +++ b/arch/arm/mach-exynos/include/mach/map.h
> @@ -57,6 +57,7 @@
>  #define EXYNOS4_PA_KEYPAD		0x100A0000
> 
>  #define EXYNOS4_PA_DMC0			0x10400000
> +#define EXYNOS4_PA_DMC1			0x10410000

If required, so just '.length = SZ_128K'?...

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
