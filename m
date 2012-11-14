From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 14 Nov 2012 15:34:00 +0100
Subject: [PATCH v2 1/2] ARM: mx27_3ds: Add VPU support
In-Reply-To: <1352899174-28022-1-git-send-email-fabio.estevam@freescale.com>
References: <1352899174-28022-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20121114143400.GM10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Wed, Nov 14, 2012 at 11:19:33AM -0200, Fabio Estevam wrote:
> mx27 has a VPU (Video Processing Unit) block that allows doing H264/MPEG4
> decoding and encoding in hardware.
> 
> Add support for it.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Do not allocate the coda buffers explicetely
> 
>  arch/arm/mach-imx/mach-mx27_3ds.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
> index d0e547f..e37a114 100644
> --- a/arch/arm/mach-imx/mach-mx27_3ds.c
> +++ b/arch/arm/mach-imx/mach-mx27_3ds.c
> @@ -531,6 +531,7 @@ static void __init mx27pdk_init(void)
>  	imx27_add_imx_ssi(0, &mx27_3ds_ssi_pdata);
>  
>  	imx_add_platform_device("imx_mc13783", 0, NULL, 0, NULL, 0);
> +	imx27_add_coda();

Why in the board? It's always present so I would register it in the SoC.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
