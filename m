From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 29 May 2012 11:08:40 +0200
Subject: [PATCH] ARM: mx31_3ds: Fix build due to missing
 IMX_HAVE_PLATFORM_IMX_SSI
In-Reply-To: <1337627346-23906-1-git-send-email-fabio.estevam@freescale.com>
References: <1337627346-23906-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120529090840.GA30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2012 at 04:09:06PM -0300, Fabio Estevam wrote:
> commit 5fb86e5 (ARM: mx31_3ds: Add sound support) missed to select IMX_HAVE_PLATFORM_IMX_SSI,
> which causes the following build error when only mx31_3ds is selected:
> 
> arch/arm/mach-imx/built-in.o: In function `mx31_3ds_init':
> mach-mx31_3ds.c:(.init.text+0x15dc): undefined reference to `imx_add_imx_ssi'
> mach-mx31_3ds.c:(.init.text+0x16b8): undefined reference to `imx31_imx_ssi_data'

Applied, thanks

Sascha

> 
> Select IMX_HAVE_PLATFORM_IMX_SSI to fix it.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> This applies agains linux-next
>  arch/arm/mach-imx/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 0021f72..eff4db5 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -477,6 +477,7 @@ config MACH_MX31_3DS
>  	select IMX_HAVE_PLATFORM_IMX2_WDT
>  	select IMX_HAVE_PLATFORM_IMX_I2C
>  	select IMX_HAVE_PLATFORM_IMX_KEYPAD
> +	select IMX_HAVE_PLATFORM_IMX_SSI
>  	select IMX_HAVE_PLATFORM_IMX_UART
>  	select IMX_HAVE_PLATFORM_IPU_CORE
>  	select IMX_HAVE_PLATFORM_MXC_EHCI
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
