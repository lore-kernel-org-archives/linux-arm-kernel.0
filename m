From: HenryC.Chen@mediatek.com (Henry Chen)
Date: Fri, 13 Mar 2015 15:44:30 +0800
Subject: [PATCH 3/5] clk: mediatek: Add basic clocks for Mediatek MT8135.
In-Reply-To: <1424605765-19751-4-git-send-email-s.hauer@pengutronix.de>
References: <1424605765-19751-1-git-send-email-s.hauer@pengutronix.de>
 <1424605765-19751-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1426232670.1716.21.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2015-02-22 at 12:49 +0100, Sascha Hauer wrote:
> +#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, _pd_reg, _pd_shift, _tuner_reg, _pcw_reg, _pcw_shift) { \
> +		.id = _id,						\
> +		.name = _name,						\
> +		.reg = _reg,						\
> +		.pwr_reg = _pwr_reg,					\
> +		.en_mask = _en_mask,					\
> +		.flags = _flags,					\
> +		.rst_bar_mask = CON0_MT8135_RST_BAR,			\
> +		.fmax = MT8135_PLL_FMAX,				\
> +		.pcwbits = _pcwbits,					\
> +		.pd_reg = _pd_reg,					\
> +		.pd_shift = _pd_shift,					\
> +		.tuner_reg = _tuner_reg,				\
> +		.pcw_reg = _pcw_reg,					\
> +		.pcw_shift = _pcw_shift,				\
> +	}
> +
> +static struct mtk_pll_data plls[] = {
> +	PLL(APMIXED_ARMPLL1, "armpll1", 0x200, 0x218, 0x80000001, 0, 21, 0x204, 24, 0x0, 0x204, 0),
> +	PLL(APMIXED_ARMPLL2, "armpll2", 0x2cc, 0x2e4, 0x80000001, 0, 21, 0x2d0, 24, 0x0, 0x2d0, 0),
> +	PLL(APMIXED_MAINPLL, "mainpll", 0x21c, 0x234, 0xf0000001, HAVE_RST_BAR, 21, 0x21c, 6, 0x0, 0x220, 0),
> +	PLL(APMIXED_UNIVPLL, "univpll", 0x238, 0x250, 0xf3000001, HAVE_RST_BAR, 7, 0x238, 6, 0x0, 0x238, 9),
> +	PLL(APMIXED_MMPLL, "mmpll", 0x254, 0x26c, 0xf0000001, HAVE_RST_BAR, 21, 0x254, 6, 0x0, 0x258, 0),
> +	PLL(APMIXED_MSDCPLL, "msdcpll", 0x278, 0x290, 0x80000001, 0, 21, 0x278, 6, 0x0, 0x27c, 0),
> +	PLL(APMIXED_TVDPLL, "tvdpll", 0x294, 0x2ac, 0x80000001, 0, 31, 0x296, 6, 0x0, 0x298, 0),

Hi Sasha,

The pd_reg of tvdpll should be 0x294.

Henry

> +	PLL(APMIXED_LVDSPLL, "lvdspll", 0x2b0, 0x2c8,	0x80000001, 0, 21, 0x2b0, 6, 0x0, 0x2b4, 0),
> +	PLL(APMIXED_AUDPLL, "audpll", 0x2e8, 0x300, 0x80000001, 0, 31, 0x2e8, 6, 0x2f8, 0x2ec, 0),
> +	PLL(APMIXED_VDECPLL, "vdecpll", 0x304, 0x31c,	0x80000001, 0, 21, 0x2b0, 6, 0x0, 0x308, 0),
> +};
> 	15
> +#define TOP_MMPLL_D5		16
> +#define TOP_MMPLL_D7		17
> +#define TOP_MMPLL_D4		18
> +#define TOP_MMPLL_D6		19
> +#define TOP_SYSPLL_D2		20
> +#define TOP_SYSPLL_D4		21
> +#define TOP_SYSPLL_D6		22
> +#define TOP_SYSPLL_D8		23
> +#define TOP_SYSPLL_D10		24
> +#define TOP_SYSPLL_D12		25
> +#define TOP_SYSPLL_D16		26
> +#define TOP_SYSPLL_D24		27
> +#define TOP_SYSPLL_D3		28
> +#define TOP_SYSPLL_D2P5		29
> +#define TOP_SYSPLL_D5		30
> +#define TOP_SYSPLL_D3P5		31
> +#define TOP_UNIVPLL1_D2		32
> +#define TOP_UNIVPLL1_D4		33
> +#define TOP_UNIVPLL1_D6		34
> +#define TOP_UNIVPLL1_D8		35
> +#define TOP_UNIVPLL1_D10	36
> +#define TOP_UNIVPLL2_D2		37
> +#define TOP_UNIVPLL2_D4		38
> +#define TOP_UNIVPLL2_D6		39
> +#define TOP_UNIVPLL2_D8		40
> +#define TOP_UNIVPLL_D3		41
> +#define TOP_UNIVPLL_D5		42
> +#define TOP_UNIVPLL_D7		43
> +#define TOP_UNIVPLL_D10		44
> +#define TOP_UNIVPLL_D26		45
> +#define TOP_APLL_CK		46
> +#define TOP_APLL_D4		47
> +#define TOP_APLL_D8		48
> +#define TOP_APLL_D16		49
> +#define TOP_APLL_D24		50
> +#define TOP_LVDSPLL_D2		51
> +#define TOP_LVDSPLL_D4		52
> +#define TOP_LVDSPLL_D8		53
> +#define TOP_LVDSTX_CLKDIG_CT	54
> +#define TOP_VPLL_DPIX_CK	55
> +#define TOP_TVHDMI_H_CK		56
> +#define TOP_HDMITX_CLKDIG_D2	57
> +#define TOP_HDMITX_CLKDIG_D3	58
> +#define TOP_TVHDMI_D2		59
> +#define TOP_TVHDMI_D4		60
> +#define TOP_MEMPLL_MCK_D4	61
> +#define TOP_AXI_SEL		62
> +#define TOP_SMI_SEL		63
> +#define TOP_MFG_SEL		64
> +#define TOP_IRDA_SEL		65
> +#define TOP_CAM_SEL		66
> +#define TOP_AUD_INTBUS_SEL	67
> +#define TOP_JPG_SEL		68
> +#define TOP_DISP_SEL		69
> +#define TOP_MSDC30_1_SEL	70
> +#define TOP_MSDC30_2_SEL	71
> +#define TOP_MSDC30_3_SEL	72
> +#define TOP_MSDC30_4_SEL	73
> +#define TOP_USB20_SEL		74
> +#define TOP_VENC_SEL		75
> +#define TOP_SPI_SEL		76
> +#define TOP_UART_SEL		77
> +#define TOP_MEM_SEL		78
> +#define TOP_CAMTG_SEL		79
> +#define TOP_AUDIO_SEL		80
> +#define TOP_FIX_SEL		81
> +#define TOP_VDEC_SEL		82
> +#define TOP_DDRPHYCFG_SEL	83
> +#define TOP_DPILVDS_SEL		84
> +#define TOP_PMICSPI_SEL		85
> +#define TOP_MSDC30_0_SEL	86
> +#define TOP_SMI_MFG_AS_SEL	87
> +#define TOP_GCPU_SEL		88
> +#define TOP_DPI1_SEL		89
> +#define TOP_CCI_SEL		90
> +#define TOP_APLL_SEL		91
> +#define TOP_HDMIPLL_SEL		92
> +#define TOP_NR_CLK		93
> +
> +/* APMIXED_SYS */
> +
> +#define APMIXED_ARMPLL1		1
> +#define APMIXED_ARMPLL2		2
> +#define APMIXED_MAINPLL		3
> +#define APMIXED_UNIVPLL		4
> +#define APMIXED_MMPLL		5
> +#define APMIXED_MSDCPLL		6
> +#define APMIXED_TVDPLL		7
> +#define APMIXED_LVDSPLL		8
> +#define APMIXED_AUDPLL		9
> +#define APMIXED_VDECPLL		10
> +#define APMIXED_NR_CLK		11
> +
> +/* INFRA_SYS */
> +
> +#define INFRA_PMIC_WRAP_CK	1
> +#define INFRA_PMICSPI_CK	2
> +#define INFRA_CCIF1_AP_CTRL	3
> +#define INFRA_CCIF0_AP_CTRL	4
> +#define INFRA_KP_CK		5
> +#define INFRA_CPUM_CK		6
> +#define INFRA_M4U_CK		7
> +#define INFRA_MFGAXI_CK		8
> +#define INFRA_DEVAPC_CK		9
> +#define INFRA_AUDIO_CK		10
> +#define INFRA_MFG_BUS_CK	11
> +#define INFRA_SMI_CK		12
> +#define INFRA_DBGCLK_CK		13
> +#define INFRA_NR_CLK		14
> +
> +/* PERI_SYS */
> +
> +#define PERI_I2C5_CK		1
> +#define PERI_I2C4_CK		2
> +#define PERI_I2C3_CK		3
> +#define PERI_I2C2_CK		4
> +#define PERI_I2C1_CK		5
> +#define PERI_I2C0_CK		6
> +#define PERI_UART3_CK		7
> +#define PERI_UART2_CK		8
> +#define PERI_UART1_CK		9
> +#define PERI_UART0_CK		10
> +#define PERI_IRDA_CK		11
> +#define PERI_NLI_CK		12
> +#define PERI_MD_HIF_CK		13
> +#define PERI_AP_HIF_CK		14
> +#define PERI_MSDC30_3_CK	15
> +#define PERI_MSDC30_2_CK	16
> +#define PERI_MSDC30_1_CK	17
> +#define PERI_MSDC20_2_CK	18
> +#define PERI_MSDC20_1_CK	19
> +#define PERI_AP_DMA_CK		20
> +#define PERI_USB1_CK		21
> +#define PERI_USB0_CK		22
> +#define PERI_PWM_CK		23
> +#define PERI_PWM7_CK		24
> +#define PERI_PWM6_CK		25
> +#define PERI_PWM5_CK		26
> +#define PERI_PWM4_CK		27
> +#define PERI_PWM3_CK		28
> +#define PERI_PWM2_CK		29
> +#define PERI_PWM1_CK		30
> +#define PERI_THERM_CK		31
> +#define PERI_NFI_CK		32
> +#define PERI_USBSLV_CK		33
> +#define PERI_USB1_MCU_CK	34
> +#define PERI_USB0_MCU_CK	35
> +#define PERI_GCPU_CK		36
> +#define PERI_FHCTL_CK		37
> +#define PERI_SPI1_CK		38
> +#define PERI_AUXADC_CK		39
> +#define PERI_PERI_PWRAP_CK	40
> +#define PERI_I2C6_CK		41
> +#define PERI_NR_CLK		42
> +
> +#endif /* _DT_BINDINGS_CLK_MT8135_H */
> diff --git a/include/dt-bindings/reset-controller/mt8135-resets.h b/include/dt-bindings/reset-controller/mt8135-resets.h
> new file mode 100644
> index 0000000..1fb6295
> --- /dev/null
> +++ b/include/dt-bindings/reset-controller/mt8135-resets.h
> @@ -0,0 +1,64 @@
> +/*
> + * Copyright (c) 2014 MediaTek Inc.
> + * Author: Flora Fu, MediaTek
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8135
> +#define _DT_BINDINGS_RESET_CONTROLLER_MT8135
> +
> +/* INFRACFG resets */
> +#define MT8135_INFRA_EMI_REG_RST        0
> +#define MT8135_INFRA_DRAMC0_A0_RST      1
> +#define MT8135_INFRA_CCIF0_RST          2
> +#define MT8135_INFRA_APCIRQ_EINT_RST    3
> +#define MT8135_INFRA_APXGPT_RST         4
> +#define MT8135_INFRA_SCPSYS_RST         5
> +#define MT8135_INFRA_CCIF1_RST          6
> +#define MT8135_INFRA_PMIC_WRAP_RST      7
> +#define MT8135_INFRA_KP_RST             8
> +#define MT8135_INFRA_EMI_RST            32
> +#define MT8135_INFRA_DRAMC0_RST         34
> +#define MT8135_INFRA_SMI_RST            35
> +#define MT8135_INFRA_M4U_RST            36
> +
> +/*  PERICFG resets */
> +#define MT8135_PERI_UART0_SW_RST        0
> +#define MT8135_PERI_UART1_SW_RST        1
> +#define MT8135_PERI_UART2_SW_RST        2
> +#define MT8135_PERI_UART3_SW_RST        3
> +#define MT8135_PERI_IRDA_SW_RST         4
> +#define MT8135_PERI_PTP_SW_RST          5
> +#define MT8135_PERI_AP_HIF_SW_RST       6
> +#define MT8135_PERI_GPCU_SW_RST         7
> +#define MT8135_PERI_MD_HIF_SW_RST       8
> +#define MT8135_PERI_NLI_SW_RST          9
> +#define MT8135_PERI_AUXADC_SW_RST       10
> +#define MT8135_PERI_DMA_SW_RST          11
> +#define MT8135_PERI_NFI_SW_RST          14
> +#define MT8135_PERI_PWM_SW_RST          15
> +#define MT8135_PERI_THERM_SW_RST        16
> +#define MT8135_PERI_MSDC0_SW_RST        17
> +#define MT8135_PERI_MSDC1_SW_RST        18
> +#define MT8135_PERI_MSDC2_SW_RST        19
> +#define MT8135_PERI_MSDC3_SW_RST        20
> +#define MT8135_PERI_I2C0_SW_RST         22
> +#define MT8135_PERI_I2C1_SW_RST         23
> +#define MT8135_PERI_I2C2_SW_RST         24
> +#define MT8135_PERI_I2C3_SW_RST         25
> +#define MT8135_PERI_I2C4_SW_RST         26
> +#define MT8135_PERI_I2C5_SW_RST         27
> +#define MT8135_PERI_I2C6_SW_RST         28
> +#define MT8135_PERI_USB_SW_RST          29
> +#define MT8135_PERI_SPI1_SW_RST         33
> +#define MT8135_PERI_PWRAP_BRIDGE_SW_RST 34
> +
> +#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8135 */
