From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 09 Sep 2010 20:26:17 +0900
Subject: [PATCH] ARM: Samsung: s5p-fimc: decrease IO registers memory
	region size
In-Reply-To: <1283998956-15327-1-git-send-email-m.szyprowski@samsung.com>
References: <1283998956-15327-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <012001cb5011$d5109150$7f31b3f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> From: Sylwester Nawrocki <s.nawrocki@samsung.com>
> 
> IO registers region size of all FIMC versions is less than 1kB so there
> is no need to reserve 1M.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/plat-s5p/dev-fimc0.c |    2 +-
>  arch/arm/plat-s5p/dev-fimc1.c |    2 +-
>  arch/arm/plat-s5p/dev-fimc2.c |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-s5p/dev-fimc0.c b/arch/arm/plat-s5p/dev-fimc0.c
> index f9203fa..608770f 100644
> --- a/arch/arm/plat-s5p/dev-fimc0.c
> +++ b/arch/arm/plat-s5p/dev-fimc0.c
> @@ -19,7 +19,7 @@
>  static struct resource s5p_fimc0_resource[] = {
>  	[0] = {
>  		.start	= S5P_PA_FIMC0,
> -		.end	= S5P_PA_FIMC0 + SZ_1M - 1,
> +		.end	= S5P_PA_FIMC0 + SZ_4K - 1,
>  		.flags	= IORESOURCE_MEM,
>  	},
>  	[1] = {
> diff --git a/arch/arm/plat-s5p/dev-fimc1.c b/arch/arm/plat-s5p/dev-fimc1.c
> index 7ed91a3..76e3a97 100644
> --- a/arch/arm/plat-s5p/dev-fimc1.c
> +++ b/arch/arm/plat-s5p/dev-fimc1.c
> @@ -19,7 +19,7 @@
>  static struct resource s5p_fimc1_resource[] = {
>  	[0] = {
>  		.start	= S5P_PA_FIMC1,
> -		.end	= S5P_PA_FIMC1 + SZ_1M - 1,
> +		.end	= S5P_PA_FIMC1 + SZ_4K - 1,
>  		.flags	= IORESOURCE_MEM,
>  	},
>  	[1] = {
> diff --git a/arch/arm/plat-s5p/dev-fimc2.c b/arch/arm/plat-s5p/dev-fimc2.c
> index 5543d6373..24d2981 100644
> --- a/arch/arm/plat-s5p/dev-fimc2.c
> +++ b/arch/arm/plat-s5p/dev-fimc2.c
> @@ -19,7 +19,7 @@
>  static struct resource s5p_fimc2_resource[] = {
>  	[0] = {
>  		.start	= S5P_PA_FIMC2,
> -		.end	= S5P_PA_FIMC2 + SZ_1M - 1,
> +		.end	= S5P_PA_FIMC2 + SZ_4K - 1,
>  		.flags	= IORESOURCE_MEM,
>  	},
>  	[1] = {
> --
> 1.7.2.2

Ok...will apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
