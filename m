From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Nov 2018 19:39:24 -0600
Subject: [RFC PATCH v4 12/17] dt-bindings: clock: Add Allwinner suniv
 F1C100s CCU
In-Reply-To: <c2e6e3f510d5663ecf25262126dcff1df112af15.1543131714.git.mesihkilinc@gmail.com>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
 <c2e6e3f510d5663ecf25262126dcff1df112af15.1543131714.git.mesihkilinc@gmail.com>
Message-ID: <20181127013924.GA23537@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 25, 2018 at 10:43:15AM +0300, Mesih Kilinc wrote:
> Add compatiple string for Allwinner suniv F1C100s CCU.
> Add clock and reset definitions.
> 
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  .../devicetree/bindings/clock/sunxi-ccu.txt        |  1 +
>  include/dt-bindings/clock/suniv-ccu-f1c100s.h      | 69 ++++++++++++++++++++++
>  include/dt-bindings/reset/suniv-ccu-f1c100s.h      | 37 ++++++++++++
>  3 files changed, 107 insertions(+)
>  create mode 100644 include/dt-bindings/clock/suniv-ccu-f1c100s.h
>  create mode 100644 include/dt-bindings/reset/suniv-ccu-f1c100s.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
> index 47d2e90..e3bd88a 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
> @@ -22,6 +22,7 @@ Required properties :
>  		- "allwinner,sun50i-h5-ccu"
>  		- "allwinner,sun50i-h6-ccu"
>  		- "allwinner,sun50i-h6-r-ccu"
> +		- "allwinner,suniv-f1c100s-ccu"
>  		- "nextthing,gr8-ccu"
>  
>  - reg: Must contain the registers base address and length
> diff --git a/include/dt-bindings/clock/suniv-ccu-f1c100s.h b/include/dt-bindings/clock/suniv-ccu-f1c100s.h
> new file mode 100644
> index 0000000..56f6d0d
> --- /dev/null
> +++ b/include/dt-bindings/clock/suniv-ccu-f1c100s.h
> @@ -0,0 +1,69 @@
> +/*
> + * Copyright (c) 2018 Icenowy Zheng <icenowy@aosc.xyz>
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)

Goes on 1st line.

> + */
> +
> +#ifndef _DT_BINDINGS_CLK_SUNIV_F1C100S_H_
> +#define _DT_BINDINGS_CLK_SUNIV_F1C100S_H_
> +
> +#define CLK_CPU			11
> +
> +#define CLK_BUS_MMC0		14
> +#define CLK_BUS_MMC1		15
> +#define CLK_BUS_DRAM		16
> +#define CLK_BUS_SPI0		17
> +#define CLK_BUS_SPI1		18
> +#define CLK_BUS_OTG		19
> +#define CLK_BUS_VE		20
> +#define CLK_BUS_LCD		21
> +#define CLK_BUS_DEINTERLACE	22
> +#define CLK_BUS_CSI		23
> +#define CLK_BUS_TVD		24
> +#define CLK_BUS_TVE		25
> +#define CLK_BUS_DE_BE		26
> +#define CLK_BUS_DE_FE		27
> +#define CLK_BUS_CODEC		28
> +#define CLK_BUS_SPDIF		29
> +#define CLK_BUS_IR		30
> +#define CLK_BUS_RSB		31
> +#define CLK_BUS_I2S0		32
> +#define CLK_BUS_I2C0		33
> +#define CLK_BUS_I2C1		34
> +#define CLK_BUS_I2C2		35
> +#define CLK_BUS_PIO		36
> +#define CLK_BUS_UART0		37
> +#define CLK_BUS_UART1		38
> +#define CLK_BUS_UART2		39
> +
> +#define CLK_MMC0		40
> +#define CLK_MMC0_SAMPLE		41
> +#define CLK_MMC0_OUTPUT		42
> +#define CLK_MMC1		43
> +#define CLK_MMC1_SAMPLE		44
> +#define CLK_MMC1_OUTPUT		45
> +#define CLK_I2S			46
> +#define CLK_SPDIF		47
> +
> +#define CLK_USB_PHY0		48
> +
> +#define CLK_DRAM_VE		49
> +#define CLK_DRAM_CSI		50
> +#define CLK_DRAM_DEINTERLACE	51
> +#define CLK_DRAM_TVD		52
> +#define CLK_DRAM_DE_FE		53
> +#define CLK_DRAM_DE_BE		54
> +
> +#define CLK_DE_BE		55
> +#define CLK_DE_FE		56
> +#define CLK_TCON		57
> +#define CLK_DEINTERLACE		58
> +#define CLK_TVE2_CLK		59
> +#define CLK_TVE1_CLK		60
> +#define CLK_TVD			61
> +#define CLK_CSI			62
> +#define CLK_VE			63
> +#define CLK_CODEC		64
> +#define CLK_AVS			65
> +
> +#endif
> diff --git a/include/dt-bindings/reset/suniv-ccu-f1c100s.h b/include/dt-bindings/reset/suniv-ccu-f1c100s.h
> new file mode 100644
> index 0000000..95f1ed0
> --- /dev/null
> +++ b/include/dt-bindings/reset/suniv-ccu-f1c100s.h
> @@ -0,0 +1,37 @@
> +/*
> + * Copyright (C) 2018 Icenowy Zheng <icenowy@aosc.xyz>
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)

ditto

> + */
> +
> +#ifndef _DT_BINDINGS_RST_SUNIV_F1C100S_H_
> +#define _DT_BINDINGS_RST_SUNIV_F1C100S_H_
> +
> +#define RST_USB_PHY0		0
> +#define RST_BUS_MMC0		1
> +#define RST_BUS_MMC1		2
> +#define RST_BUS_DRAM		3
> +#define RST_BUS_SPI0		4
> +#define RST_BUS_SPI1		5
> +#define RST_BUS_OTG		6
> +#define RST_BUS_VE		7
> +#define RST_BUS_LCD		8
> +#define RST_BUS_DEINTERLACE		9
> +#define RST_BUS_CSI		10
> +#define RST_BUS_TVD		11
> +#define RST_BUS_TVE		12
> +#define RST_BUS_DE_BE		13
> +#define RST_BUS_DE_FE		14
> +#define RST_BUS_CODEC		15
> +#define RST_BUS_SPDIF		16
> +#define RST_BUS_IR		17
> +#define RST_BUS_RSB		18
> +#define RST_BUS_I2S0		19
> +#define RST_BUS_I2C0		20
> +#define RST_BUS_I2C1		21
> +#define RST_BUS_I2C2		22
> +#define RST_BUS_UART0		23
> +#define RST_BUS_UART1		24
> +#define RST_BUS_UART2		25
> +
> +#endif /* _DT_BINDINGS_RST_SUNIV_F1C100S_H_ */
> -- 
> 2.7.4
> 
