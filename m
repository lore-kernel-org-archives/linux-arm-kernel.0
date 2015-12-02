From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 2 Dec 2015 14:52:25 +0800
Subject: [PATCH] ARM: dts: imx53: fix EIM_D27/29 pad UART2 configuration
In-Reply-To: <1448535555-17130-1-git-send-email-linux-kernel-dev@beckhoff.com>
References: <1448535555-17130-1-git-send-email-linux-kernel-dev@beckhoff.com>
Message-ID: <20151202065225.GK692@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 11:59:15AM +0100, linux-kernel-dev at beckhoff.com wrote:
> From: Patrick Br?nn <p.bruenn@beckhoff.com>
> 
> MX53_PAD_EIM_D27__UART2_RXD_MUX and MX53_PAD_EIM_D29__UART2_RTS input_val must be configured as 0 instead of 1 to have UART2 muxed on EIM pins working

I'm not sure why you think that.  But the i.MX53 Reference Manual in my
hands doesn't agree with that.  It says ...

> 
> Signed-off-by: Patrick Br?nn <p.bruenn@beckhoff.com>
> ---
>  arch/arm/boot/dts/imx53-pinfunc.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx53-pinfunc.h b/arch/arm/boot/dts/imx53-pinfunc.h
> index aec406b..a4c973d 100644
> --- a/arch/arm/boot/dts/imx53-pinfunc.h
> +++ b/arch/arm/boot/dts/imx53-pinfunc.h
> @@ -532,7 +532,7 @@
>  #define MX53_PAD_EIM_D26__IPU_DISP1_DAT_22			0x144 0x48c 0x000 0x7 0x0
>  #define MX53_PAD_EIM_D27__EMI_WEIM_D_27				0x148 0x490 0x000 0x0 0x0
>  #define MX53_PAD_EIM_D27__GPIO3_27				0x148 0x490 0x000 0x1 0x0
> -#define MX53_PAD_EIM_D27__UART2_RXD_MUX				0x148 0x490 0x880 0x2 0x1
> +#define MX53_PAD_EIM_D27__UART2_RXD_MUX				0x148 0x490 0x880 0x2 0x0

IOMUXC_UART2_IPP_UART_RXD_MUX_SELECT_INPUT DAISY field descriptions

000 - Selecting Pad: EIM_D26 for Mode: ALT2.
001 - Selecting Pad: EIM_D27 for Mode: ALT2.
010 - Selecting Pad: PATA_DMARQ for Mode: ALT3.
011 - Selecting Pad: PATA_BUFFER_EN for Mode: ALT3.
100 - Selecting Pad: GPIO_7 for Mode: ALT4.
101 - Selecting Pad: GPIO_8 for Mode: ALT4.

>  #define MX53_PAD_EIM_D27__FIRI_TXD				0x148 0x490 0x000 0x3 0x0
>  #define MX53_PAD_EIM_D27__IPU_CSI0_D_0				0x148 0x490 0x000 0x4 0x0
>  #define MX53_PAD_EIM_D27__IPU_DI1_PIN13				0x148 0x490 0x000 0x5 0x0
> @@ -548,7 +548,7 @@
>  #define MX53_PAD_EIM_D28__IPU_DI0_PIN13				0x14c 0x494 0x000 0x7 0x0
>  #define MX53_PAD_EIM_D29__EMI_WEIM_D_29				0x150 0x498 0x000 0x0 0x0
>  #define MX53_PAD_EIM_D29__GPIO3_29				0x150 0x498 0x000 0x1 0x0
> -#define MX53_PAD_EIM_D29__UART2_RTS				0x150 0x498 0x87c 0x2 0x1
> +#define MX53_PAD_EIM_D29__UART2_RTS				0x150 0x498 0x87c 0x2 0x0

IOMUXC_UART2_IPP_UART_RTS_B_SELECT_INPUT DAISY field descriptions

00 - Selecting Pad: EIM_D28 for Mode: ALT2.
01 - Selecting Pad: EIM_D29 for Mode: ALT2.
10 - Selecting Pad: PATA_INTRQ for Mode: ALT3.
11 - Selecting Pad: PATA_DIOR for Mode: ALT3.

>  #define MX53_PAD_EIM_D29__IPU_DISPB0_SER_RS			0x150 0x498 0x000 0x3 0x0
>  #define MX53_PAD_EIM_D29__CSPI_SS0				0x150 0x498 0x78c 0x4 0x2
>  #define MX53_PAD_EIM_D29__IPU_DI1_PIN15				0x150 0x498 0x000 0x5 0x0
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
