From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 10 Dec 2010 11:15:33 +0900
Subject: [PATCH for 2.6.37] S5PV210: update MAX8998 platform data to get
	rid of WARN()
In-Reply-To: <1291907461-27447-1-git-send-email-m.szyprowski@samsung.com>
References: <1291907461-27447-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <026701cb9810$25426cc0$6fc74640$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> This patch adds new entries required by the new version of MAX8998
> driver. Without them, the driver fails to init. See commit 50f19a4596
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> ---
> 
> Hello,
> 
Hi

> This is quite important bugfix for 2.6.37 release. I'm really sorry that

No problem :-)

> I forgot to send it earlier.
> 
Yeah would be better.

Anyway, ok...will apply into s5p-fixes-for-linus branch for 37.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> ---
>  arch/arm/mach-s5pv210/mach-aquila.c |    6 ++++++
>  arch/arm/mach-s5pv210/mach-goni.c   |    6 ++++++
>  2 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-
> s5pv210/mach-aquila.c
> index 28677ca..461aa035 100644
> --- a/arch/arm/mach-s5pv210/mach-aquila.c
> +++ b/arch/arm/mach-s5pv210/mach-aquila.c
> @@ -378,6 +378,12 @@ static struct max8998_regulator_data
aquila_regulators[]
> = {
>  static struct max8998_platform_data aquila_max8998_pdata = {
>  	.num_regulators	= ARRAY_SIZE(aquila_regulators),
>  	.regulators	= aquila_regulators,
> +	.buck1_set1	= S5PV210_GPH0(3),
> +	.buck1_set2	= S5PV210_GPH0(4),
> +	.buck2_set3	= S5PV210_GPH0(5),
> +	.buck1_max_voltage1 = 1200000,
> +	.buck1_max_voltage2 = 1200000,
> +	.buck2_max_voltage = 1200000,
>  };
>  #endif
> 
> diff --git a/arch/arm/mach-s5pv210/mach-goni.c
b/arch/arm/mach-s5pv210/mach-
> goni.c
> index b1dcf96..e22d511 100644
> --- a/arch/arm/mach-s5pv210/mach-goni.c
> +++ b/arch/arm/mach-s5pv210/mach-goni.c
> @@ -518,6 +518,12 @@ static struct max8998_regulator_data
goni_regulators[] =
> {
>  static struct max8998_platform_data goni_max8998_pdata = {
>  	.num_regulators	= ARRAY_SIZE(goni_regulators),
>  	.regulators	= goni_regulators,
> +	.buck1_set1	= S5PV210_GPH0(3),
> +	.buck1_set2	= S5PV210_GPH0(4),
> +	.buck2_set3	= S5PV210_GPH0(5),
> +	.buck1_max_voltage1 = 1200000,
> +	.buck1_max_voltage2 = 1200000,
> +	.buck2_max_voltage = 1200000,
>  };
>  #endif
> 
> --
