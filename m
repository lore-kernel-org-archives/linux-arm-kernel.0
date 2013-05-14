From: horms@verge.net.au (Simon Horman)
Date: Tue, 14 May 2013 09:35:04 +0900
Subject: [PATCH 05/14] ARM: shmobile: Remove init_irq declaration in
 machine description
In-Reply-To: <1368438253-28218-6-git-send-email-maxime.ripard@free-electrons.com>
References: <1368438253-28218-1-git-send-email-maxime.ripard@free-electrons.com>
 <1368438253-28218-6-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130514003504.GE12228@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 13, 2013 at 11:44:04AM +0200, Maxime Ripard wrote:
> Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
> specified") removed the need to explictly setup the init_irq field in
> the machine description when using only irqchip_init. Remove that
> declaration for shmobile as well.

Hi Maxime,

If possible, I would prefer separate patches for each board and SoC.

> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/mach-shmobile/board-ape6evm.c         | 1 -
>  arch/arm/mach-shmobile/board-kzm9g-reference.c | 1 -
>  arch/arm/mach-shmobile/board-lager.c           | 1 -
>  arch/arm/mach-shmobile/setup-emev2.c           | 1 -
>  arch/arm/mach-shmobile/setup-r8a73a4.c         | 1 -
>  arch/arm/mach-shmobile/setup-r8a7790.c         | 1 -
>  arch/arm/mach-shmobile/setup-sh73a0.c          | 1 -
>  7 files changed, 7 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
> index 55b8c9f..913ce31 100644
> --- a/arch/arm/mach-shmobile/board-ape6evm.c
> +++ b/arch/arm/mach-shmobile/board-ape6evm.c
> @@ -87,7 +87,6 @@ static const char *ape6evm_boards_compat_dt[] __initdata = {
>  };
>  
>  DT_MACHINE_START(APE6EVM_DT, "ape6evm")
> -	.init_irq	= irqchip_init,
>  	.init_time	= shmobile_timer_init,
>  	.init_machine	= ape6evm_add_standard_devices,
>  	.dt_compat	= ape6evm_boards_compat_dt,
> diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
> index aefa50d..eaec498 100644
> --- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
> +++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
> @@ -100,7 +100,6 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
>  	.map_io		= sh73a0_map_io,
>  	.init_early	= sh73a0_init_delay,
>  	.nr_irqs	= NR_IRQS_LEGACY,
> -	.init_irq	= irqchip_init,
>  	.init_machine	= kzm_init,
>  	.init_time	= shmobile_timer_init,
>  	.dt_compat	= kzm9g_boards_compat_dt,
> diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
> index f587187..c384c9f 100644
> --- a/arch/arm/mach-shmobile/board-lager.c
> +++ b/arch/arm/mach-shmobile/board-lager.c
> @@ -39,7 +39,6 @@ static const char *lager_boards_compat_dt[] __initdata = {
>  };
>  
>  DT_MACHINE_START(LAGER_DT, "lager")
> -	.init_irq	= irqchip_init,
>  	.init_time	= r8a7790_timer_init,
>  	.init_machine	= lager_add_standard_devices,
>  	.dt_compat	= lager_boards_compat_dt,
> diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
> index 899a86c..098ca63 100644
> --- a/arch/arm/mach-shmobile/setup-emev2.c
> +++ b/arch/arm/mach-shmobile/setup-emev2.c
> @@ -454,7 +454,6 @@ DT_MACHINE_START(EMEV2_DT, "Generic Emma Mobile EV2 (Flattened Device Tree)")
>  	.smp		= smp_ops(emev2_smp_ops),
>  	.init_early	= emev2_init_delay,
>  	.nr_irqs	= NR_IRQS_LEGACY,
> -	.init_irq	= irqchip_init,
>  	.init_machine	= emev2_add_standard_devices_dt,
>  	.dt_compat	= emev2_boards_compat_dt,
>  MACHINE_END
> diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
> index c5a75a7..6b19d50 100644
> --- a/arch/arm/mach-shmobile/setup-r8a73a4.c
> +++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
> @@ -194,7 +194,6 @@ static const char *r8a73a4_boards_compat_dt[] __initdata = {
>  };
>  
>  DT_MACHINE_START(R8A73A4_DT, "Generic R8A73A4 (Flattened Device Tree)")
> -	.init_irq	= irqchip_init,
>  	.init_machine	= r8a73a4_add_standard_devices_dt,
>  	.init_time	= shmobile_timer_init,
>  	.dt_compat	= r8a73a4_boards_compat_dt,
> diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
> index 49de2d5..d639aad 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7790.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7790.c
> @@ -142,7 +142,6 @@ static const char *r8a7790_boards_compat_dt[] __initdata = {
>  };
>  
>  DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
> -	.init_irq	= irqchip_init,
>  	.init_machine	= r8a7790_add_standard_devices_dt,
>  	.init_time	= r8a7790_timer_init,
>  	.dt_compat	= r8a7790_boards_compat_dt,
> diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
> index fdf3894..3a7d24a 100644
> --- a/arch/arm/mach-shmobile/setup-sh73a0.c
> +++ b/arch/arm/mach-shmobile/setup-sh73a0.c
> @@ -1035,7 +1035,6 @@ DT_MACHINE_START(SH73A0_DT, "Generic SH73A0 (Flattened Device Tree)")
>  	.map_io		= sh73a0_map_io,
>  	.init_early	= sh73a0_init_delay,
>  	.nr_irqs	= NR_IRQS_LEGACY,
> -	.init_irq	= irqchip_init,
>  	.init_machine	= sh73a0_add_standard_devices_dt,
>  	.dt_compat	= sh73a0_boards_compat_dt,
>  MACHINE_END
> -- 
> 1.8.1.2
> 
