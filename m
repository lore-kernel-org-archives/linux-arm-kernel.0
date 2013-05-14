From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 14 May 2013 17:17:48 +0800
Subject: [PATCH 11/14] ARM: sirf: Remove init_irq declaration in machine
 description
In-Reply-To: <1368438253-28218-12-git-send-email-maxime.ripard@free-electrons.com>
References: <1368438253-28218-1-git-send-email-maxime.ripard@free-electrons.com>
 <1368438253-28218-12-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGsJ_4wH2cEHdvzYUE4eeFbtr427kYdWFPDVR8DZ_-s5=sG7wQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/5/13 Maxime Ripard <maxime.ripard@free-electrons.com>:
> Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
> specified") removed the need to explictly setup the init_irq field in
> the machine description when using only irqchip_init. Remove that
> declaration for sirf as well.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Barry Song <Baohua.Song@csr.com>

> ---
>  arch/arm/mach-prima2/common.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
> index 4f94cd8..52e28cf 100644
> --- a/arch/arm/mach-prima2/common.c
> +++ b/arch/arm/mach-prima2/common.c
> @@ -55,7 +55,6 @@ DT_MACHINE_START(ATLAS6_DT, "Generic ATLAS6 (Flattened Device Tree)")
>         /* Maintainer: Barry Song <baohua.song@csr.com> */
>         .nr_irqs        = 128,
>         .map_io         = sirfsoc_map_io,
> -       .init_irq       = irqchip_init,
>         .init_time      = sirfsoc_init_time,
>         .init_machine   = sirfsoc_mach_init,
>         .init_late      = sirfsoc_init_late,
> @@ -74,7 +73,6 @@ DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
>         /* Maintainer: Barry Song <baohua.song@csr.com> */
>         .nr_irqs        = 128,
>         .map_io         = sirfsoc_map_io,
> -       .init_irq       = irqchip_init,
>         .init_time      = sirfsoc_init_time,
>         .dma_zone_size  = SZ_256M,
>         .init_machine   = sirfsoc_mach_init,
> @@ -94,7 +92,6 @@ DT_MACHINE_START(MARCO_DT, "Generic MARCO (Flattened Device Tree)")
>         /* Maintainer: Barry Song <baohua.song@csr.com> */
>         .smp            = smp_ops(sirfsoc_smp_ops),
>         .map_io         = sirfsoc_map_io,
> -       .init_irq       = irqchip_init,
>         .init_time      = sirfsoc_init_time,
>         .init_machine   = sirfsoc_mach_init,
>         .init_late      = sirfsoc_init_late,
> --
> 1.8.1.2
