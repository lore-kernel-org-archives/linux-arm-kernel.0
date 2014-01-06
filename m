From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 6 Jan 2014 14:12:37 +0800
Subject: [PATCH] ARM: i.MX51: Fix IOMUX settings
In-Reply-To: <1388550301-31215-1-git-send-email-shc_work@mail.ru>
References: <1388550301-31215-1-git-send-email-shc_work@mail.ru>
Message-ID: <20140106061233.GE27227@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 01, 2014 at 08:25:01AM +0400, Alexander Shiyan wrote:
> This patch fix daisy channel settings for MX51_PAD_EIM_D26__UART3_TXD and
> MX51_PAD_AUD3_BB_FS__UART3_TXD pads. Add missing SION bit for W1 pad.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Normally, we do not take non-DT platform code change anymore.  But since
it's a simple fix, I applied it.

Shawn

> ---
>  arch/arm/mach-imx/iomux-mx51.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/iomux-mx51.h b/arch/arm/mach-imx/iomux-mx51.h
> index 75bbcc4..e370c98 100644
> --- a/arch/arm/mach-imx/iomux-mx51.h
> +++ b/arch/arm/mach-imx/iomux-mx51.h
> @@ -111,7 +111,7 @@
>  #define MX51_PAD_EIM_D26__EIM_D26		IOMUX_PAD(0x418, 0x084, 0, __NA_, 0, NO_PAD_CTRL)
>  #define MX51_PAD_EIM_D26__KEY_COL7		IOMUX_PAD(0x418, 0x084, 1, 0x9cc, 0, NO_PAD_CTRL)
>  #define MX51_PAD_EIM_D26__UART2_RTS		IOMUX_PAD(0x418, 0x084, 4, 0x9e8, 3, MX51_UART_PAD_CTRL)
> -#define MX51_PAD_EIM_D26__UART3_TXD		IOMUX_PAD(0x418, 0x084, 3, __NA_, 0, MX51_UART_PAD_CTRL)
> +#define MX51_PAD_EIM_D26__UART3_TXD		IOMUX_PAD(0x418, 0x084, 3, 0x9f4, 1, MX51_UART_PAD_CTRL)
>  #define MX51_PAD_EIM_D26__USBOTG_DATA2		IOMUX_PAD(0x418, 0x084, 2, __NA_, 0, NO_PAD_CTRL)
>  #define MX51_PAD_EIM_D26__GPT_CMPOUT2		IOMUX_PAD(0x418, 0x084, 5, __NA_, 0, NO_PAD_CTRL)
>  #define MX51_PAD_EIM_D27__AUD6_RXC		IOMUX_PAD(0x41c, 0x088, 5, 0x8f4, 0, NO_PAD_CTRL)
> @@ -451,7 +451,7 @@
>  #define MX51_PAD_AUD3_BB_CK__GPIO4_20		IOMUX_PAD(0x5f8, 0x208, 3, __NA_, 0, MX51_GPIO_PAD_CTRL)
>  #define MX51_PAD_AUD3_BB_FS__AUD3_TXFS		IOMUX_PAD(0x5fc, 0x20c, 0, __NA_, 0, NO_PAD_CTRL)
>  #define MX51_PAD_AUD3_BB_FS__GPIO4_21		IOMUX_PAD(0x5fc, 0x20c, 3, __NA_, 0, MX51_GPIO_PAD_CTRL)
> -#define MX51_PAD_AUD3_BB_FS__UART3_TXD		IOMUX_PAD(0x5fc, 0x20c, 1, __NA_, 0, MX51_UART_PAD_CTRL)
> +#define MX51_PAD_AUD3_BB_FS__UART3_TXD		IOMUX_PAD(0x5fc, 0x20c, 1, 0x9f4, 3, MX51_UART_PAD_CTRL)
>  #define MX51_PAD_CSPI1_MOSI__ECSPI1_MOSI	IOMUX_PAD(0x600, 0x210, 0, __NA_, 0, MX51_ECSPI_PAD_CTRL)
>  #define MX51_PAD_CSPI1_MOSI__GPIO4_22		IOMUX_PAD(0x600, 0x210, 3, __NA_, 0, MX51_GPIO_PAD_CTRL)
>  #define MX51_PAD_CSPI1_MOSI__I2C1_SDA		IOMUX_PAD(0x600, 0x210, 0x11, 0x9b4, 1, MX51_I2C_PAD_CTRL)
> @@ -494,7 +494,7 @@
>  #define MX51_PAD_UART3_TXD__UART1_DSR		IOMUX_PAD(0x634, 0x244, 0, __NA_, 0, MX51_UART_PAD_CTRL)
>  #define MX51_PAD_UART3_TXD__UART3_TXD		IOMUX_PAD(0x634, 0x244, 1, __NA_, 0, MX51_UART_PAD_CTRL)
>  #define MX51_PAD_OWIRE_LINE__GPIO1_24		IOMUX_PAD(0x638, 0x248, 3, __NA_, 0, MX51_GPIO_PAD_CTRL)
> -#define MX51_PAD_OWIRE_LINE__OWIRE_LINE		IOMUX_PAD(0x638, 0x248, 0, __NA_, 0, NO_PAD_CTRL)
> +#define MX51_PAD_OWIRE_LINE__OWIRE_LINE		IOMUX_PAD(0x638, 0x248, 0x10, __NA_, 0, NO_PAD_CTRL)
>  #define MX51_PAD_OWIRE_LINE__SPDIF_OUT		IOMUX_PAD(0x638, 0x248, 6, __NA_, 0, NO_PAD_CTRL)
>  #define MX51_PAD_KEY_ROW0__KEY_ROW0		IOMUX_PAD(0x63c, 0x24c, 0, __NA_, 0, NO_PAD_CTRL)
>  #define MX51_PAD_KEY_ROW1__KEY_ROW1		IOMUX_PAD(0x640, 0x250, 0, __NA_, 0, NO_PAD_CTRL)
> -- 
> 1.8.3.2
> 
