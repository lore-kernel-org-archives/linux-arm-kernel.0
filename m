From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 21 May 2013 21:24:30 +0200
Subject: [PATCH] ARM: iomux-mx51: Always define PUE for pins used as GPIO
In-Reply-To: <1369124845-19244-1-git-send-email-shc_work@mail.ru>
References: <1369124845-19244-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130521192430.GU32299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 21, 2013 at 12:27:25PM +0400, Alexander Shiyan wrote:
> This patch adds a PUE bit for pins which used as GPIO. This allow
> to use the GPIOs correctly as inputs when source is open-drain with
> external pullup resistor (IRQ open-drain outputs for example).

I don't understand. If there's an external pullup why do you want to
turn on the internal one?

Sascha

> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/mach-imx/iomux-mx51.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/iomux-mx51.h b/arch/arm/mach-imx/iomux-mx51.h
> index 75bbcc4..7dc187c 100644
> --- a/arch/arm/mach-imx/iomux-mx51.h
> +++ b/arch/arm/mach-imx/iomux-mx51.h
> @@ -34,7 +34,8 @@
>  #define MX51_SDHCI_PAD_CTRL	(PAD_CTL_PKE | PAD_CTL_DSE_HIGH | \
>  				PAD_CTL_PUS_47K_UP | PAD_CTL_PUE | \
>  				PAD_CTL_SRE_FAST | PAD_CTL_DVS)
> -#define MX51_GPIO_PAD_CTRL	(PAD_CTL_DSE_HIGH | PAD_CTL_PKE | PAD_CTL_SRE_FAST)
> +#define MX51_GPIO_PAD_CTRL	(PAD_CTL_DSE_HIGH | PAD_CTL_PKE | \
> +				PAD_CTL_PUE | PAD_CTL_SRE_FAST)
>  
>  #define MX51_PAD_CTRL_2		(PAD_CTL_PKE | PAD_CTL_HYS)
>  #define MX51_PAD_CTRL_3		(PAD_CTL_PKE | PAD_CTL_PUS_100K_UP)
> -- 
> 1.8.1.5
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
