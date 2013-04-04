From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 4 Apr 2013 15:03:25 +0530
Subject: [PATCH v8 1/2] ARM: davinci: dm365: add support for v4l2 video
 display
In-Reply-To: <1364903681-13914-2-git-send-email-prabhakar.csengg@gmail.com>
References: <1364903681-13914-1-git-send-email-prabhakar.csengg@gmail.com>
 <1364903681-13914-2-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <515D48E5.1060700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/2/2013 5:24 PM, Prabhakar lad wrote:
> From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> 
> Create platform devices for various video modules like venc,osd,
> vpbe and v4l2 driver for dm365.
> 
> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Minor nits below:

> diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
> index c61dd94..786c860 100644
> --- a/arch/arm/mach-davinci/dm365.c
> +++ b/arch/arm/mach-davinci/dm365.c
> @@ -40,10 +40,14 @@
>  
>  #define DM365_REF_FREQ		24000000	/* 24 MHz on the DM365 EVM */
>  
> +#define DM365_RTC_BASE			0x01c69000
> +
>  /* Base of key scan register bank */
>  #define DM365_KEYSCAN_BASE		0x01c69400
>  
> -#define DM365_RTC_BASE			0x01c69000
> +#define DM365_OSD_BASE			0x01c71c00
> +
> +#define DM365_VENC_BASE			0x01c71e00
>  
>  #define DAVINCI_DM365_VC_BASE		0x01d0c000

No need of empty lines between these definitions. While at it you can
also remove the useless comment "/* Base of key scan register bank */"

> +static int dm365_vpbe_setup_pinmux(enum v4l2_mbus_pixelcode if_type,
> +			    int field)
> +{
> +	switch (if_type) {
> +	case V4L2_MBUS_FMT_SGRBG8_1X8:
> +		davinci_cfg_reg(DM365_VOUT_FIELD_G81);
> +		davinci_cfg_reg(DM365_VOUT_COUTL_EN);
> +		davinci_cfg_reg(DM365_VOUT_COUTH_EN);
> +		break;
> +

No need of these empty lines after 'break'. Here and other places below.

The patch looks good overall though so you can fix the nits and add:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
