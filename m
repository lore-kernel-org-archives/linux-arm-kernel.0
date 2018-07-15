From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Sun, 15 Jul 2018 20:08:49 +0530
Subject: [PATCH v4 2/5] dt-bindings: clock: Add S700 support for Actions
 Semi Soc's
In-Reply-To: <20180715123145.16975-3-sravanhome@gmail.com>
References: <20180715123145.16975-1-sravanhome@gmail.com>
 <20180715123145.16975-3-sravanhome@gmail.com>
Message-ID: <20180715143849.GC9980@Mani-XPS-13-9360>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Saravanan,

On Sun, Jul 15, 2018 at 02:31:42PM +0200, Saravanan Sekar wrote:
> Add clock bindings constants for action S700
> Maintain common clock dt-bindings for Actions Semi SoC's
> S700 and S900.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  ...tions,s900-cmu.txt => actions,owl-cmu.txt} |  20 +--
>  include/dt-bindings/clock/actions,s700-cmu.h  | 118 ++++++++++++++++++
>  2 files changed, 129 insertions(+), 9 deletions(-)
>  rename Documentation/devicetree/bindings/clock/{actions,s900-cmu.txt => actions,owl-cmu.txt} (67%)
>  create mode 100644 include/dt-bindings/clock/actions,s700-cmu.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/actions,s900-cmu.txt b/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
> similarity index 67%
> rename from Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
> rename to Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
> index 93e4fb827cd6..d737ea74a450 100644
> --- a/Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
> +++ b/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
> @@ -1,12 +1,14 @@
> -* Actions S900 Clock Management Unit (CMU)
> +* Actions Semi Owl Clock Management Unit (CMU)
>  
> -The Actions S900 clock management unit generates and supplies clock to various
> -controllers within the SoC. The clock binding described here is applicable to
> -S900 SoC.
> +The Actions Semi S900/S700 clock management unit generates and supplies clock

Shouldn't it be, "Actions Semi Owl Clock Management Unit"?

Thanks,
Mani

> +to various controllers within the SoC. The clock binding described here is
> +applicable to S900 and S700 SoC's.
>  
>  Required Properties:
>  
> -- compatible: should be "actions,s900-cmu"
> +- compatible: should be one of the following,
> +	"actions,s900-cmu"
> +	"actions,s700-cmu"
>  - reg: physical base address of the controller and length of memory mapped
>    region.
>  - clocks: Reference to the parent clocks ("hosc", "losc")
> @@ -15,16 +17,16 @@ Required Properties:
>  Each clock is assigned an identifier, and client nodes can use this identifier
>  to specify the clock which they consume.
>  
> -All available clocks are defined as preprocessor macros in
> -dt-bindings/clock/actions,s900-cmu.h header and can be used in device
> -tree sources.
> +All available clocks are defined as preprocessor macros in corresponding
> +dt-bindings/clock/actions,s900-cmu.h or actions,s700-cmu.h header and can be
> +used in device tree sources.
>  
>  External clocks:
>  
>  The hosc clock used as input for the plls is generated outside the SoC. It is
>  expected that it is defined using standard clock bindings as "hosc".
>  
> -Actions S900 CMU also requires one more clock:
> +Actions Semi S900 CMU also requires one more clock:
>   - "losc" - internal low frequency oscillator
>  
>  Example: Clock Management Unit node:
> diff --git a/include/dt-bindings/clock/actions,s700-cmu.h b/include/dt-bindings/clock/actions,s700-cmu.h
> new file mode 100644
> index 000000000000..905808bf335b
> --- /dev/null
> +++ b/include/dt-bindings/clock/actions,s700-cmu.h
> @@ -0,0 +1,118 @@
> +/* SPDX-License-Identifier: GPL-2.0+
> + *
> + * Actions S700 clock driver

Should be:

Device Tree binding constants for Actions Semi S700 Clock Management Unit

Thanks,
Mani

> + *
> + * Copyright (c) 2014 Actions Semi Inc.
> + * Author: David Liu <liuwei@actions-semi.com>
> + *
> + * Author: Pathiban Nallathambi <pn@denx.de>
> + * Author: Saravanan Sekar <sravanhome@gmail.com>
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_S700_H
> +#define __DT_BINDINGS_CLOCK_S700_H
> +
> +#define CLK_NONE			0
> +
> +/* pll clocks */
> +#define CLK_CORE_PLL			1
> +#define CLK_DEV_PLL			2
> +#define CLK_DDR_PLL			3
> +#define CLK_NAND_PLL			4
> +#define CLK_DISPLAY_PLL			5
> +#define CLK_TVOUT_PLL			6
> +#define CLK_CVBS_PLL			7
> +#define CLK_AUDIO_PLL			8
> +#define CLK_ETHERNET_PLL		9
> +
> +/* system clock */
> +#define CLK_CPU				10
> +#define CLK_DEV				11
> +#define CLK_AHB				12
> +#define CLK_APB				13
> +#define CLK_DMAC			14
> +#define CLK_NOC0_CLK_MUX		15
> +#define CLK_NOC1_CLK_MUX		16
> +#define CLK_HP_CLK_MUX			17
> +#define CLK_HP_CLK_DIV			18
> +#define CLK_NOC1_CLK_DIV		19
> +#define CLK_NOC0			20
> +#define CLK_NOC1			21
> +#define CLK_SENOR_SRC			22
> +
> +/* peripheral device clock */
> +#define CLK_GPIO			23
> +#define CLK_TIMER			24
> +#define CLK_DSI				25
> +#define CLK_CSI				26
> +#define CLK_SI				27
> +#define CLK_DE				28
> +#define CLK_HDE				29
> +#define CLK_VDE				30
> +#define CLK_VCE				31
> +#define CLK_NAND			32
> +#define CLK_SD0				33
> +#define CLK_SD1				34
> +#define CLK_SD2				35
> +
> +#define CLK_UART0			36
> +#define CLK_UART1			37
> +#define CLK_UART2			38
> +#define CLK_UART3			39
> +#define CLK_UART4			40
> +#define CLK_UART5			41
> +#define CLK_UART6			42
> +
> +#define CLK_PWM0			43
> +#define CLK_PWM1			44
> +#define CLK_PWM2			45
> +#define CLK_PWM3			46
> +#define CLK_PWM4			47
> +#define CLK_PWM5			48
> +#define CLK_GPU3D			49
> +
> +#define CLK_I2C0			50
> +#define CLK_I2C1			51
> +#define CLK_I2C2			52
> +#define CLK_I2C3			53
> +
> +#define CLK_SPI0			54
> +#define CLK_SPI1			55
> +#define CLK_SPI2			56
> +#define CLK_SPI3			57
> +
> +#define CLK_USB3_480MPLL0		58
> +#define CLK_USB3_480MPHY0		59
> +#define CLK_USB3_5GPHY			60
> +#define CLK_USB3_CCE			61
> +#define CLK_USB3_MAC			62
> +
> +#define CLK_LCD				63
> +#define CLK_HDMI_AUDIO			64
> +#define CLK_I2SRX			65
> +#define CLK_I2STX			66
> +
> +#define CLK_SENSOR0			67
> +#define CLK_SENSOR1			68
> +
> +#define CLK_HDMI_DEV			69
> +
> +#define CLK_ETHERNET			70
> +#define CLK_RMII_REF			71
> +
> +#define CLK_USB2H0_PLLEN		72
> +#define CLK_USB2H0_PHY			73
> +#define CLK_USB2H0_CCE			74
> +#define CLK_USB2H1_PLLEN		75
> +#define CLK_USB2H1_PHY			76
> +#define CLK_USB2H1_CCE			77
> +
> +#define CLK_TVOUT			78
> +
> +#define CLK_THERMAL_SENSOR		79
> +
> +#define CLK_IRC_SWITCH			80
> +#define CLK_PCM1			81
> +#define CLK_NR_CLKS			(CLK_PCM1 + 1)
> +
> +#endif /* __DT_BINDINGS_CLOCK_S700_H */
> -- 
> 2.18.0
> 
