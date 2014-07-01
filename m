From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 01 Jul 2014 11:06:24 +0200
Subject: [PATCH] ARM: imx: mark .dt_compat as const
In-Reply-To: <1404201991-28704-1-git-send-email-shawn.guo@freescale.com>
References: <1404201991-28704-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1404205584.4241.0.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 01.07.2014, 16:06 +0800 schrieb Shawn Guo:
> Otherwise GCC will mark the .init.rodata section R/W, which causes
> a compile error once we add other real R/O data.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  arch/arm/mach-imx/imx31-dt.c    | 2 +-
>  arch/arm/mach-imx/imx35-dt.c    | 2 +-
>  arch/arm/mach-imx/mach-imx50.c  | 2 +-
>  arch/arm/mach-imx/mach-imx51.c  | 2 +-
>  arch/arm/mach-imx/mach-imx53.c  | 2 +-
>  arch/arm/mach-imx/mach-imx6q.c  | 2 +-
>  arch/arm/mach-imx/mach-imx6sl.c | 2 +-
>  arch/arm/mach-imx/mach-imx6sx.c | 2 +-
>  arch/arm/mach-imx/mach-vf610.c  | 2 +-
>  9 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/imx31-dt.c b/arch/arm/mach-imx/imx31-dt.c
> index 581f4d6c9b8a..418dbc82adc4 100644
> --- a/arch/arm/mach-imx/imx31-dt.c
> +++ b/arch/arm/mach-imx/imx31-dt.c
> @@ -25,7 +25,7 @@ static void __init imx31_dt_init(void)
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  }
>  
> -static const char *imx31_dt_board_compat[] __initconst = {
> +static const char * const imx31_dt_board_compat[] __initconst = {
>  	"fsl,imx31",
>  	NULL
>  };
> diff --git a/arch/arm/mach-imx/imx35-dt.c b/arch/arm/mach-imx/imx35-dt.c
> index a62854c59240..584fbe105579 100644
> --- a/arch/arm/mach-imx/imx35-dt.c
> +++ b/arch/arm/mach-imx/imx35-dt.c
> @@ -34,7 +34,7 @@ static void __init imx35_irq_init(void)
>  	mx35_init_irq();
>  }
>  
> -static const char *imx35_dt_board_compat[] __initconst = {
> +static const char * const imx35_dt_board_compat[] __initconst = {
>  	"fsl,imx35",
>  	NULL
>  };
> diff --git a/arch/arm/mach-imx/mach-imx50.c b/arch/arm/mach-imx/mach-imx50.c
> index 62a4d4580291..b1e56a94a382 100644
> --- a/arch/arm/mach-imx/mach-imx50.c
> +++ b/arch/arm/mach-imx/mach-imx50.c
> @@ -23,7 +23,7 @@ static void __init imx50_dt_init(void)
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  }
>  
> -static const char *imx50_dt_board_compat[] __initconst = {
> +static const char * const imx50_dt_board_compat[] __initconst = {
>  	"fsl,imx50",
>  	NULL
>  };
> diff --git a/arch/arm/mach-imx/mach-imx51.c b/arch/arm/mach-imx/mach-imx51.c
> index b6f42f80aae2..c77deb3f0893 100644
> --- a/arch/arm/mach-imx/mach-imx51.c
> +++ b/arch/arm/mach-imx/mach-imx51.c
> @@ -67,7 +67,7 @@ static void __init imx51_init_late(void)
>  	imx51_pm_init();
>  }
>  
> -static const char *imx51_dt_board_compat[] __initconst = {
> +static const char * const imx51_dt_board_compat[] __initconst = {
>  	"fsl,imx51",
>  	NULL
>  };
> diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
> index d8c3c08354f6..03a0b40793d6 100644
> --- a/arch/arm/mach-imx/mach-imx53.c
> +++ b/arch/arm/mach-imx/mach-imx53.c
> @@ -41,7 +41,7 @@ static void __init imx53_init_late(void)
>  	imx53_pm_init();
>  }
>  
> -static const char *imx53_dt_board_compat[] __initconst = {
> +static const char * const imx53_dt_board_compat[] __initconst = {
>  	"fsl,imx53",
>  	NULL
>  };
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index e60456d85c9d..5604993458f8 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -396,7 +396,7 @@ static void __init imx6q_init_irq(void)
>  	irqchip_init();
>  }
>  
> -static const char *imx6q_dt_compat[] __initconst = {
> +static const char * const imx6q_dt_compat[] __initconst = {
>  	"fsl,imx6dl",
>  	"fsl,imx6q",
>  	NULL,
> diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
> index ad323385115c..ed263a21d928 100644
> --- a/arch/arm/mach-imx/mach-imx6sl.c
> +++ b/arch/arm/mach-imx/mach-imx6sl.c
> @@ -70,7 +70,7 @@ static void __init imx6sl_init_irq(void)
>  	irqchip_init();
>  }
>  
> -static const char *imx6sl_dt_compat[] __initconst = {
> +static const char * const imx6sl_dt_compat[] __initconst = {
>  	"fsl,imx6sl",
>  	NULL,
>  };
> diff --git a/arch/arm/mach-imx/mach-imx6sx.c b/arch/arm/mach-imx/mach-imx6sx.c
> index 74ff7d650f8a..673a734165ba 100644
> --- a/arch/arm/mach-imx/mach-imx6sx.c
> +++ b/arch/arm/mach-imx/mach-imx6sx.c
> @@ -44,7 +44,7 @@ static void __init imx6sx_init_late(void)
>  	imx6q_cpuidle_init();
>  }
>  
> -static const char *imx6sx_dt_compat[] __initconst = {
> +static const char * const imx6sx_dt_compat[] __initconst = {
>  	"fsl,imx6sx",
>  	NULL,
>  };
> diff --git a/arch/arm/mach-imx/mach-vf610.c b/arch/arm/mach-imx/mach-vf610.c
> index c44602758120..ee7e57b752a7 100644
> --- a/arch/arm/mach-imx/mach-vf610.c
> +++ b/arch/arm/mach-imx/mach-vf610.c
> @@ -20,7 +20,7 @@ static void __init vf610_init_machine(void)
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  }
>  
> -static const char *vf610_dt_compat[] __initconst = {
> +static const char * const vf610_dt_compat[] __initconst = {
>  	"fsl,vf610",
>  	NULL,
>  };

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
