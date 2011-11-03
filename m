From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 3 Nov 2011 08:03:38 +0100
Subject: [PATCH] iomux-mx25: configuration to support CSPI3 on CSI pins
In-Reply-To: <201110311123.p9VBNMWY017281@home.pavel.comp>
References: <201110311123.p9VBNMWY017281@home.pavel.comp>
Message-ID: <20111103070337.GA16886@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 31, 2011 at 03:04:26PM +0400, Paul Fertser wrote:
> This adds necessary defines for the CSPI3 module (activated with
> imx25_add_spi_imx2()) to work on the CSI pins (alternative mode 7).
> 
> Signed-off-by: Paul Fertser <fercerpav@gmail.com>

Ok, I queued this up

> ---
> Tested on real hardware

Thanks ;)

Sascha

> 
>  arch/arm/plat-mxc/include/mach/iomux-mx25.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx25.h b/arch/arm/plat-mxc/include/mach/iomux-mx25.h
> index bf64e1e..f0726d4 100644
> --- a/arch/arm/plat-mxc/include/mach/iomux-mx25.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-mx25.h
> @@ -265,16 +265,20 @@
>  #define MX25_PAD_CSI_D2__CSI_D2		IOMUX_PAD(0x318, 0x120, 0x10, 0, 0, NO_PAD_CTRL)
>  #define MX25_PAD_CSI_D2__UART5_RXD_MUX	IOMUX_PAD(0x318, 0x120, 0x11, 0x578, 1, NO_PAD_CTRL)
>  #define MX25_PAD_CSI_D2__GPIO_1_27	IOMUX_PAD(0x318, 0x120, 0x15, 0, 0, NO_PAD_CTRL)
> +#define MX25_PAD_CSI_D2__CSPI3_MOSI	IOMUX_PAD(0x318, 0x120, 0x17, 0, 0, NO_PAD_CTRL)
>  
>  #define MX25_PAD_CSI_D3__CSI_D3		IOMUX_PAD(0x31c, 0x124, 0x10, 0, 0, NO_PAD_CTRL)
>  #define MX25_PAD_CSI_D3__GPIO_1_28	IOMUX_PAD(0x31c, 0x124, 0x15, 0, 0, NO_PAD_CTRL)
> +#define MX25_PAD_CSI_D3__CSPI3_MISO	IOMUX_PAD(0x31c, 0x124, 0x17, 0x4b4, 1, NO_PAD_CTRL)
>  
>  #define MX25_PAD_CSI_D4__CSI_D4		IOMUX_PAD(0x320, 0x128, 0x10, 0, 0, NO_PAD_CTRL)
>  #define MX25_PAD_CSI_D4__UART5_RTS	IOMUX_PAD(0x320, 0x128, 0x11, 0x574, 1, NO_PAD_CTRL)
>  #define MX25_PAD_CSI_D4__GPIO_1_29	IOMUX_PAD(0x320, 0x128, 0x15, 0, 0, NO_PAD_CTRL)
> +#define MX25_PAD_CSI_D4__CSPI3_SCLK	IOMUX_PAD(0x320, 0x128, 0x17, 0, 0, NO_PAD_CTRL)
>  
>  #define MX25_PAD_CSI_D5__CSI_D5		IOMUX_PAD(0x324, 0x12c, 0x10, 0, 0, NO_PAD_CTRL)
>  #define MX25_PAD_CSI_D5__GPIO_1_30	IOMUX_PAD(0x324, 0x12c, 0x15, 0, 0, NO_PAD_CTRL)
> +#define MX25_PAD_CSI_D5__CSPI3_RDY	IOMUX_PAD(0x324, 0x12c, 0x17, 0, 0, NO_PAD_CTRL)
>  
>  #define MX25_PAD_CSI_D6__CSI_D6		IOMUX_PAD(0x328, 0x130, 0x10, 0, 0, NO_PAD_CTRL)
>  #define MX25_PAD_CSI_D6__GPIO_1_31	IOMUX_PAD(0x328, 0x130, 0x15, 0, 0, NO_PAD_CTRL)
> -- 
> 1.7.2.3
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
