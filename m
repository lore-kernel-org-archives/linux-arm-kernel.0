From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 17 Nov 2017 14:08:41 +0100
Subject: [PATCH 1/3] dt-bindings: reset: Add bindings for the Meson-AXG
 SoC Reset Controller
In-Reply-To: <20171110084650.31325-1-yixun.lan@amlogic.com>
References: <20171110084650.31325-1-yixun.lan@amlogic.com>
Message-ID: <92df6e7a-41cf-6221-fa64-88fa249f0a6d@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2017 09:46, Yixun Lan wrote:
> Add DT bindings for the Meson-AXG SoC Reset Controller include file,
> and also slightly update documentation.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  .../bindings/reset/amlogic,meson-reset.txt         |   3 +-
>  .../dt-bindings/reset/amlogic,meson-axg-reset.h    | 124 +++++++++++++++++++++
>  2 files changed, 126 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/reset/amlogic,meson-axg-reset.h
> 
> diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt
> index e746b631793a..28ef6c295c76 100644
> --- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt
> +++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt
> @@ -5,7 +5,8 @@ Please also refer to reset.txt in this directory for common reset
>  controller binding usage.
>  
>  Required properties:
> -- compatible: Should be "amlogic,meson8b-reset" or "amlogic,meson-gxbb-reset"
> +- compatible: Should be "amlogic,meson8b-reset", "amlogic,meson-gxbb-reset" or
> +	"amlogic,meson-axg-reset".
>  - reg: should contain the register address base
>  - #reset-cells: 1, see below
>  
> diff --git a/include/dt-bindings/reset/amlogic,meson-axg-reset.h b/include/dt-bindings/reset/amlogic,meson-axg-reset.h
> new file mode 100644
> index 000000000000..ad6f55dabd6d
> --- /dev/null
> +++ b/include/dt-bindings/reset/amlogic,meson-axg-reset.h
> @@ -0,0 +1,124 @@
> +/*
> + *
> + * Copyright (c) 2016 BayLibre, SAS.
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + *
> + * Copyright (c) 2017 Amlogic, inc.
> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR BSD)
> + */
> +
> +#ifndef _DT_BINDINGS_AMLOGIC_MESON_AXG_RESET_H
> +#define _DT_BINDINGS_AMLOGIC_MESON_AXG_RESET_H
> +
> +/*	RESET0					*/
> +#define RESET_HIU			0
> +#define RESET_PCIE_A			1
> +#define RESET_PCIE_B			2
> +#define RESET_DDR_TOP			3
> +/*					4	*/
> +#define RESET_VIU			5
> +#define RESET_PCIE_PHY			6
> +#define RESET_PCIE_APB			7
> +/*					8	*/
> +/*					9	*/
> +#define RESET_VENC			10
> +#define RESET_ASSIST			11
> +/*					12	*/
> +#define RESET_VCBUS			13
> +/*					14	*/
> +/*					15	*/
> +#define RESET_GIC			16
> +#define RESET_CAPB3_DECODE		17
> +/*					18-21	*/
> +#define RESET_SYS_CPU_CAPB3		22
> +#define RESET_CBUS_CAPB3		23
> +#define RESET_AHB_CNTL			24
> +#define RESET_AHB_DATA			25
> +#define RESET_VCBUS_CLK81		26
> +#define RESET_MMC			27
> +/*					28-31	*/
> +/*	RESET1					*/
> +/*					32	*/
> +/*					33	*/
> +#define RESET_USB_OTG			34
> +#define RESET_DDR			35
> +#define RESET_AO_RESET			36
> +/*					37	*/
> +#define RESET_AHB_SRAM			38
> +/*					39	*/
> +/*					40	*/
> +#define RESET_DMA			41
> +#define RESET_ISA			42
> +#define RESET_ETHERNET			43
> +/*					44	*/
> +#define RESET_SD_EMMC_B			45
> +#define RESET_SD_EMMC_C			46
> +#define RESET_ROM_BOOT			47
> +#define RESET_SYS_CPU_0			48
> +#define RESET_SYS_CPU_1			49
> +#define RESET_SYS_CPU_2			50
> +#define RESET_SYS_CPU_3			51
> +#define RESET_SYS_CPU_CORE_0		52
> +#define RESET_SYS_CPU_CORE_1		53
> +#define RESET_SYS_CPU_CORE_2		54
> +#define RESET_SYS_CPU_CORE_3		55
> +#define RESET_SYS_PLL_DIV		56
> +#define RESET_SYS_CPU_AXI		57
> +#define RESET_SYS_CPU_L2		58
> +#define RESET_SYS_CPU_P			59
> +#define RESET_SYS_CPU_MBIST		60
> +/*					61-63	*/
> +/*	RESET2					*/
> +/*					64	*/
> +/*					65	*/
> +#define RESET_AUDIO			66
> +/*					67	*/
> +#define RESET_MIPI_HOST			68
> +#define RESET_AUDIO_LOCKER		69
> +#define RESET_GE2D			70
> +/*					71-76	*/
> +#define RESET_AO_CPU_RESET		77
> +/*					78-95	*/
> +/*	RESET3					*/
> +#define RESET_RING_OSCILLATOR		96
> +/*					97-127	*/
> +/*	RESET4					*/
> +/*					128	*/
> +/*					129	*/
> +#define RESET_MIPI_PHY			130
> +/*					131-140	*/
> +#define RESET_VENCL			141
> +#define RESET_I2C_MASTER_2		142
> +#define RESET_I2C_MASTER_1		143
> +/*					144-159	*/
> +/*	RESET5					*/
> +/*					160-191	*/
> +/*	RESET6					*/
> +#define RESET_PERIPHS_GENERAL		192
> +#define RESET_PERIPHS_SPICC		193
> +/*					194	*/
> +/*					195	*/
> +#define RESET_PERIPHS_I2C_MASTER_0	196
> +/*					197-200	*/
> +#define RESET_PERIPHS_UART_0		201
> +#define RESET_PERIPHS_UART_1		202
> +/*					203-204	*/
> +#define RESET_PERIPHS_SPI_0		205
> +#define RESET_PERIPHS_I2C_MASTER_3	206
> +/*					207-223	*/
> +/*	RESET7					*/
> +#define RESET_USB_DDR_0			224
> +#define RESET_USB_DDR_1			225
> +#define RESET_USB_DDR_2			226
> +#define RESET_USB_DDR_3			227
> +/*					228	*/
> +#define RESET_DEVICE_MMC_ARB		229
> +/*					230	*/
> +#define RESET_VID_LOCK			231
> +#define RESET_A9_DMC_PIPEL		232
> +#define RESET_DMC_VPU_PIPEL		233
> +/*					234-255	*/
> +
> +#endif
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
