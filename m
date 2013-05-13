From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 13 May 2013 13:35:58 +0100
Subject: [PATCH 12/14] ARM: vexpress: Remove init_irq declaration in
 machine description
In-Reply-To: <1368438253-28218-13-git-send-email-maxime.ripard@free-electrons.com>
References: <1368438253-28218-1-git-send-email-maxime.ripard@free-electrons.com>
 <1368438253-28218-13-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1368448558.3425.2.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-05-13 at 10:44 +0100, Maxime Ripard wrote:
> Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
> specified") removed the need to explictly setup the init_irq field in
> the machine description when using only irqchip_init. Remove that
> declaration for vexpress as well.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/mach-vexpress/v2m.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
> index 8802030..c419b76 100644
> --- a/arch/arm/mach-vexpress/v2m.c
> +++ b/arch/arm/mach-vexpress/v2m.c
> @@ -458,7 +458,6 @@ DT_MACHINE_START(VEXPRESS_DT, "ARM-Versatile Express")
>  	.smp		= smp_ops(vexpress_smp_ops),
>  	.map_io		= v2m_dt_map_io,
>  	.init_early	= v2m_dt_init_early,
> -	.init_irq	= irqchip_init,
>  	.init_time	= v2m_dt_timer_init,
>  	.init_machine	= v2m_dt_init,
>  MACHINE_END

Acked-by: Pawel Moll <pawel.moll@arm.com>

Thanks!

Pawel
