From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 15 Jul 2011 15:32:41 +0200
Subject: [PATCH V2 06/10] ARM: mxs: add saif device
In-Reply-To: <1310483085-31442-7-git-send-email-b29396@freescale.com>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-7-git-send-email-b29396@freescale.com>
Message-ID: <20110715133241.GG2021@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

just noticed this one...

> diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
> index eaaf6ff..7837a87 100644
> --- a/arch/arm/mach-mxs/mach-mx28evk.c
> +++ b/arch/arm/mach-mxs/mach-mx28evk.c
> @@ -40,6 +40,8 @@
>  #define MX28EVK_MMC0_SLOT_POWER		MXS_GPIO_NR(3, 28)
>  #define MX28EVK_MMC1_SLOT_POWER		MXS_GPIO_NR(3, 29)
>  
> +#define DIGCTRL_BASE_ADDR      MX28_IO_ADDRESS(MX28_DIGCTL_BASE_ADDR)
> +

Hmm, maybe define a function mx28_set_saif_clkmux(val)?

> +	mx28_add_saif(0);
> +	mx28_add_saif(1);
> +
> +	/*set the saif clk mux, both saif0/saif1 use saif0 clk*/
> +	__raw_writel(0x2 << 10, DIGCTRL_BASE_ADDR);

You might overwrite previous settings here. The hardcoded numbers need
defines, too.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110715/7a3994ba/attachment.sig>
