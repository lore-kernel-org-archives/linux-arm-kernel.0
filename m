From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 22 Feb 2011 11:27:59 -0700 (MST)
Subject: [patch-v2.6.39 6/7] OMAP4430: hwmod data: Adding USBOTG
In-Reply-To: <4D62ECCC.3040208@ti.com>
References: <20110217171747.GC14574@legolas.emea.dhcp.ti.com>
	<4D5D59E5.6020307@ti.com>
	<20110217173711.GF14574@legolas.emea.dhcp.ti.com>
	<4D5D5F13.2010602@ti.com> <20110217181849.GV20795@atomide.com>
	<4D5E7DFF.7020609@ti.com>
	<20110218154135.GF11151@legolas.emea.dhcp.ti.com>
	<4D5EA36A.4000903@ti.com> <20110221182213.GD15225@atomide.com>
	<4D62DAF0.9050301@ti.com> <20110221220815.GG15225@atomide.com>
	<4D62ECCC.3040208@ti.com>
Message-ID: <alpine.DEB.2.00.1102221127180.22636@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Feb 2011, Cousson, Benoit wrote:

> Meanwhile, the following will just prevent the fmwk to reset and idle the
> timer during hwmod_init.
> 
> Regards,
> Benoit

Looks okay to me for the time being.

Acked-by: Paul Walmsley <paul@pwsan.com>

> 
> 
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -3989,6 +3989,7 @@ static struct omap_hwmod_ocp_if
> *omap44xx_timer1_slaves[] = {
>  static struct omap_hwmod omap44xx_timer1_hwmod = {
>  	.name		= "timer1",
>  	.class		= &omap44xx_timer_1ms_hwmod_class,
> +	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
>  	.mpu_irqs	= omap44xx_timer1_irqs,
>  	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_timer1_irqs),
>  	.main_clk	= "timer1_fck",
> 


- Paul
