From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 18 Feb 2011 18:18:58 +0900
Subject: [PATCH for 2.6.38] ARM: S5PC110: update max8998_platform_data
In-Reply-To: <1297760464-7639-1-git-send-email-m.szyprowski@samsung.com>
References: <1297760464-7639-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <020f01cbcf4c$df47f450$9dd7dcf0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> Max8998 PMIC driver's platform data has been changed once again in
> commit 735a3d9efdc. This patch fixes build break caused by that commit.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv210/mach-aquila.c |    9 ++++++---
>  arch/arm/mach-s5pv210/mach-goni.c   |    9 ++++++---
>  2 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-
> s5pv210/mach-aquila.c
> index 461aa035..1236e19 100644
> --- a/arch/arm/mach-s5pv210/mach-aquila.c
> +++ b/arch/arm/mach-s5pv210/mach-aquila.c
> @@ -381,9 +381,12 @@ static struct max8998_platform_data
aquila_max8998_pdata
> = {
>  	.buck1_set1	= S5PV210_GPH0(3),
>  	.buck1_set2	= S5PV210_GPH0(4),
>  	.buck2_set3	= S5PV210_GPH0(5),
> -	.buck1_max_voltage1 = 1200000,
> -	.buck1_max_voltage2 = 1200000,
> -	.buck2_max_voltage = 1200000,
> +	.buck1_voltage1	= 1200000,
> +	.buck1_voltage2	= 1200000,
> +	.buck1_voltage3	= 1200000,
> +	.buck1_voltage4	= 1200000,
> +	.buck2_voltage1	= 1200000,
> +	.buck2_voltage2	= 1200000,
>  };
>  #endif
> 
> diff --git a/arch/arm/mach-s5pv210/mach-goni.c
b/arch/arm/mach-s5pv210/mach-
> goni.c
> index e22d511..2beeb66 100644
> --- a/arch/arm/mach-s5pv210/mach-goni.c
> +++ b/arch/arm/mach-s5pv210/mach-goni.c
> @@ -521,9 +521,12 @@ static struct max8998_platform_data
goni_max8998_pdata =
> {
>  	.buck1_set1	= S5PV210_GPH0(3),
>  	.buck1_set2	= S5PV210_GPH0(4),
>  	.buck2_set3	= S5PV210_GPH0(5),
> -	.buck1_max_voltage1 = 1200000,
> -	.buck1_max_voltage2 = 1200000,
> -	.buck2_max_voltage = 1200000,
> +	.buck1_voltage1	= 1200000,
> +	.buck1_voltage2	= 1200000,
> +	.buck1_voltage3	= 1200000,
> +	.buck1_voltage4	= 1200000,
> +	.buck2_voltage1	= 1200000,
> +	.buck2_voltage2	= 1200000,
>  };
>  #endif
> 
> --

Ok, applied into s5p-fixes-for-linus for 38.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
