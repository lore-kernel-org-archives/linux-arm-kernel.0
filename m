From: manu@bidouilliste.com (Emmanuel Vadot)
Date: Tue, 28 Feb 2017 10:27:25 +0100
Subject: [PATCH 1/4] clk: sunxi-ng: Add clocks and reset indices for
 sun7i-a20 SoC
In-Reply-To: <20170227210914.18954-2-plaes@plaes.org>
References: <20170227210914.18954-1-plaes@plaes.org>
 <20170227210914.18954-2-plaes@plaes.org>
Message-ID: <20170228102725.0b920f1f8219e47814fb5d89@bidouilliste.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


 Hello Priit,

On Mon, 27 Feb 2017 23:09:11 +0200
Priit Laes <plaes@plaes.org> wrote:

> Add preliminary list of exported clocks and reset indices for
> sun7i-a20 SoC, based on existing sun7i-a20 devicetree implementation.
> 
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  include/dt-bindings/clock/sun7i-ccu.h | 127 ++++++++++++++++++++++++++++++++++
>  include/dt-bindings/reset/sun7i-ccu.h |  40 +++++++++++
>  2 files changed, 167 insertions(+)
>  create mode 100644 include/dt-bindings/clock/sun7i-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun7i-ccu.h
> 
> diff --git a/include/dt-bindings/clock/sun7i-ccu.h b/include/dt-bindings/clock/sun7i-ccu.h
> new file mode 100644
> index 0000000..52c4f76
> --- /dev/null
> +++ b/include/dt-bindings/clock/sun7i-ccu.h
> @@ -0,0 +1,127 @@
> +/*
> + * Copyright 2017 Priit Laes
> + *
> + * Priit Laes <plaes@plaes.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */

 Do you mind dual licence those header under GPL/MIT like the others ?
 We currently dont use those directly in FreeBSD but we should (and
will soon) and we can't if they are only GPL.

 Thanks.

> +
> +#ifndef _DT_BINDINGS_CLK_SUN7I_H_
> +#define _DT_BINDINGS_CLK_SUN7I_H_
> +
> +#define CLK_HOSC		1
> +#define CLK_PLL_PERIPH_SATA	16
> +#define CLK_CPU			19
> +
> +/* AHB Gates */
> +#define CLK_AHB_OTG		24
> +#define CLK_AHB_EHCI0		25
> +#define CLK_AHB_OHCI0		26
> +#define CLK_AHB_EHCI1		27
> +#define CLK_AHB_OHCI1		28
> +#define CLK_AHB_SS		29
> +#define CLK_AHB_DMA		30
> +
> +#define CLK_AHB_MMC0		32
> +#define CLK_AHB_MMC1		33
> +#define CLK_AHB_MMC2		34
> +#define CLK_AHB_MMC3		35
> +
> +#define CLK_AHB_NAND		37
> +
> +#define CLK_AHB_EMAC		40
> +
> +#define CLK_AHB_SPI0		42
> +#define CLK_AHB_SPI1		43
> +#define CLK_AHB_SPI2		44
> +#define CLK_AHB_SPI3		45
> +#define CLK_AHB_SATA		46
> +#define CLK_AHB_HSTIMER		47
> +
> +#define CLK_AHB_TVE0		50
> +#define CLK_AHB_LCD0		52
> +#define CLK_AHB_HDMI1		57

 We use HDMI (not HDMI1) on FreeBSD (see
https://svnweb.freebsd.org/base/head/sys/boot/fdt/dts/arm/sun7i-a20-hdmi.dtsi?revision=308672&view=markup#l71)

 If you could define it in your patch this will be great.

> +#define CLK_AHB_DE_BE0		58
> +
> +#define CLK_AHB_GMAC		62
> +
> +/* APB0 Gates */
> +#define CLK_APB0_CODEC		65
> +#define CLK_APB0_SPDIF		66
> +#define CLK_APB0_I2S0		68
> +#define CLK_APB0_I2S1		69
> +#define CLK_APB0_PIO		70
> +#define CLK_APB0_IR0		71
> +#define CLK_APB0_IR1		72
> +#define CLK_APB0_I2S2		73
> +
> +/* APB1 Gates */
> +#define CLK_APB1_I2C0		75
> +#define CLK_APB1_I2C1		76
> +#define CLK_APB1_I2C2		77
> +#define CLK_APB1_I2C3		78
> +
> +#define CLK_APB1_PS20		81
> +#define CLK_APB1_PS21		82
> +#define CLK_APB1_I2C4		83
> +#define CLK_APB1_UART0		84
> +#define CLK_APB1_UART1		85
> +#define CLK_APB1_UART2		86
> +#define CLK_APB1_UART3		87
> +#define CLK_APB1_UART4		88
> +#define CLK_APB1_UART5		89
> +#define CLK_APB1_UART6		90
> +#define CLK_APB1_UART7		91
> +
> +/* IP blocks */
> +#define CLK_NAND		92
> +
> +#define CLK_MMC0		94
> +#define CLK_MMC0_OUTPUT		95
> +#define CLK_MMC0_SAMPLE		96
> +#define CLK_MMC1		97
> +#define CLK_MMC1_OUTPUT		98
> +#define CLK_MMC1_SAMPLE		99
> +#define CLK_MMC2		100
> +#define CLK_MMC2_OUTPUT		101
> +#define CLK_MMC2_SAMPLE		102
> +#define CLK_MMC3		103
> +#define CLK_MMC3_OUTPUT		104
> +#define CLK_MMC3_SAMPLE		105
> +
> +#define CLK_SS			107
> +#define CLK_SPI0		108
> +#define CLK_SPI1		109
> +#define CLK_SPI2		110
> +#define CLK_IR0			112
> +#define CLK_IR1			113
> +#define CLK_I2S0		114
> +
> +#define CLK_SPDIF		116
> +
> +#define CLK_USB_OHCI0		119
> +#define CLK_USB_OHCI1		120
> +#define CLK_USB_PHY		121
> +#define CLK_SPI3		122
> +#define CLK_I2S1		123
> +#define CLK_I2S2		124
> +
> +/* DRAM Gates */
> +#define CLK_DRAM_TVE0		130
> +#define CLK_DRAM_DE_BE0		134
> +
> +/* Display Engine Clocks */
> +#define CLK_DE_BE0		139
> +#define CLK_TCON0_CH0		144
> +#define CLK_TCON0_CH1		149
> +#define CLK_CODEC		153
> +
> +#endif /* _DT_BINDINGS_CLK_SUN7I_H_ */
> diff --git a/include/dt-bindings/reset/sun7i-ccu.h b/include/dt-bindings/reset/sun7i-ccu.h
> new file mode 100644
> index 0000000..b8709ab
> --- /dev/null
> +++ b/include/dt-bindings/reset/sun7i-ccu.h
> @@ -0,0 +1,40 @@
> +/*
> + * Copyright 2017 Priit Laes
> + *
> + * Priit Laes <plaes@plaes.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef _RST_SUN7I_H_
> +#define _RST_SUN7I_H_
> +
> +#define	RST_USB_PHY0		1
> +#define	RST_USB_PHY1		2
> +#define	RST_USB_PHY2		3
> +#define	RST_DE_BE0		4
> +#define	RST_DE_BE1		5
> +#define	RST_DE_FE0		6
> +#define	RST_DE_FE1		7
> +#define	RST_DE_MP		8
> +#define	RST_TCON0		9
> +#define	RST_TCON1		10
> +#define	RST_CSI0		11
> +#define	RST_CSI1		12
> +#define	RST_VE			13
> +#define	RST_ACE			14
> +#define	RST_LVDS		15
> +#define	RST_GPU			16
> +#define	RST_HDMI_H		17
> +#define	RST_HDMI_SYS		18
> +#define	RST_HDMI_AUDIO_DMA	19
> +
> +#endif /* _RST_SUN7I_H_ */
> -- 
> 2.9.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
