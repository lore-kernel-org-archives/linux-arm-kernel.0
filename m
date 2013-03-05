From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 5 Mar 2013 12:07:18 +0100
Subject: [PATCH] ARM: imx: avic: Move avic_saved_mask_reg under CONFIG_PM
In-Reply-To: <1360085776-31475-1-git-send-email-fabio.estevam@freescale.com>
References: <1360085776-31475-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20130305110718.GY1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 03:36:16PM -0200, Fabio Estevam wrote:
> When building a kernel with CONFIG_PM undefined, the following warning happens:
> 
> arch/arm/mach-imx/avic.c:57:12: warning: 'avic_saved_mask_reg' defined but not used [-Wunused-variable]
> 
> Move avic_saved_mask_reg definition inside the '#ifdef CONFIG_PM' block to
> avoid the warning.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks

Sascha

> ---
>  arch/arm/mach-imx/avic.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/avic.c b/arch/arm/mach-imx/avic.c
> index 0eff23e..49c87e7 100644
> --- a/arch/arm/mach-imx/avic.c
> +++ b/arch/arm/mach-imx/avic.c
> @@ -54,8 +54,6 @@
>  void __iomem *avic_base;
>  static struct irq_domain *domain;
>  
> -static u32 avic_saved_mask_reg[2];
> -
>  #ifdef CONFIG_MXC_IRQ_PRIOR
>  static int avic_irq_set_priority(unsigned char irq, unsigned char prio)
>  {
> @@ -113,6 +111,8 @@ static struct mxc_extra_irq avic_extra_irq = {
>  };
>  
>  #ifdef CONFIG_PM
> +static u32 avic_saved_mask_reg[2];
> +
>  static void avic_irq_suspend(struct irq_data *d)
>  {
>  	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> -- 
> 1.7.9.5
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
