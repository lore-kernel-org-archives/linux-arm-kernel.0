From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 13 Oct 2014 11:21:03 +0100
Subject: [PATCH v4 04/10] ARM: add alphascale,acc.txt bindings
 documentation
In-Reply-To: <1413141561-8916-5-git-send-email-linux@rempel-privat.de>
References: <1413141561-8916-1-git-send-email-linux@rempel-privat.de>
 <1413141561-8916-5-git-send-email-linux@rempel-privat.de>
Message-ID: <20141013102103.GD14739@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 12, 2014 at 08:19:15PM +0100, Oleksij Rempel wrote:
> ACC is for AlphaScale Clock Controller.
> 
> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
> ---
>  .../devicetree/bindings/clock/alphascale,acc.txt   | 113 +++++++++++++++++++++
>  1 file changed, 113 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/alphascale,acc.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/alphascale,acc.txt b/Documentation/devicetree/bindings/clock/alphascale,acc.txt
> new file mode 100644
> index 0000000..92a03a5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/alphascale,acc.txt
> @@ -0,0 +1,113 @@
> +Alphascale Clock Controller
> +
> +The ACC (Alphascale Clock Controller) is responsible of choising proper
> +clock source, setting deviders and clock gates.
> +
> +Required properties for the ACC node:
> +- compatible: must be "alphascale,asm9260-clock-controller"
> +- reg: must contain the ACC register base and size

I take it you expect #clock-cells to be 1, and for the cell to be one of
the values below. Please point this out explictly here.

> +
> +ACC allow peripheral clocks to be gated to save some power. The clock consumer
> +should specify the desired clock by having the clock ID in it
> +"clocks" phandle cell. It is encouraged to use dt-binding for clock ID

The ID is in the clock-specifier (a tuple of cells defined by
#clock-cells), not the phandle.

> +definitions. SoC specific dt-binding should be included to the device tree
> +descriptor. For example Alphascale ASM9260:
> +#include <dt-bindings/clock/alphascale,asm9260.h>
> +
> +This binding contains two types of clock sinks: _AHB_ sink - a peripheral
> +gate; _SYS_ sink - an adjustable clock source. Not all clock consumer
> +have _SYS_ sink. All sink details can be found in the SoC documentation.

These should be described in terms of the clock provider, not the
consumer.

Thanks,
Mark.

> +CLKID_AHB_ROM		0
> +CLKID_AHB_RAM		1
> +CLKID_AHB_GPIO		2
> +CLKID_AHB_MAC		3
> +CLKID_AHB_EMI		4
> +CLKID_AHB_USB0		5
> +CLKID_AHB_USB1		6
> +CLKID_AHB_DMA0		7
> +CLKID_AHB_DMA1		8
> +CLKID_AHB_UART0		9
> +CLKID_AHB_UART1		10
> +CLKID_AHB_UART2		11
> +CLKID_AHB_UART3		12
> +CLKID_AHB_UART4		13
> +CLKID_AHB_UART5		14
> +CLKID_AHB_UART6		15
> +CLKID_AHB_UART7		16
> +CLKID_AHB_UART8		17
> +CLKID_AHB_UART9		18
> +CLKID_AHB_I2S0		19
> +CLKID_AHB_I2C0		20
> +CLKID_AHB_I2C1		21
> +CLKID_AHB_SSP0		22
> +CLKID_AHB_IOCONFIG	23
> +CLKID_AHB_WDT		24
> +CLKID_AHB_CAN0		25
> +CLKID_AHB_CAN1		26
> +CLKID_AHB_MPWM		27
> +CLKID_AHB_SPI0		28
> +CLKID_AHB_SPI1		29
> +CLKID_AHB_QEI		30
> +CLKID_AHB_QUADSPI0	31
> +CLKID_AHB_CAMIF		32
> +CLKID_AHB_LCDIF		33
> +CLKID_AHB_TIMER0	34
> +CLKID_AHB_TIMER1	35
> +CLKID_AHB_TIMER2	36
> +CLKID_AHB_TIMER3	37
> +CLKID_AHB_IRQ		38
> +CLKID_AHB_RTC		39
> +CLKID_AHB_NAND		40
> +CLKID_AHB_ADC0		41
> +CLKID_AHB_LED		42
> +CLKID_AHB_DAC0		43
> +CLKID_AHB_LCD		44
> +CLKID_AHB_I2S1		45
> +CLKID_AHB_MAC1		46
> +
> +CLKID_SYS_CPU		47
> +CLKID_SYS_AHB		48
> +CLKID_SYS_I2S0M		49
> +CLKID_SYS_I2S0S		50
> +CLKID_SYS_I2S1M		51
> +CLKID_SYS_I2S1S		52
> +CLKID_SYS_UART0		53
> +CLKID_SYS_UART1		54
> +CLKID_SYS_UART2		55
> +CLKID_SYS_UART3		56
> +CLKID_SYS_UART4		56
> +CLKID_SYS_UART5		57
> +CLKID_SYS_UART6		58
> +CLKID_SYS_UART7		59
> +CLKID_SYS_UART8		60
> +CLKID_SYS_UART9		61
> +CLKID_SYS_SPI0		62
> +CLKID_SYS_SPI1		63
> +CLKID_SYS_QUADSPI	64
> +CLKID_SYS_SSP0		65
> +CLKID_SYS_NAND		66
> +CLKID_SYS_TRACE		67
> +CLKID_SYS_CAMM		68
> +CLKID_SYS_WDT		69
> +CLKID_SYS_CLKOUT	70
> +CLKID_SYS_MAC		71
> +CLKID_SYS_LCD		72
> +CLKID_SYS_ADCANA	73
> +
> +Example of clock consumer with _SYS_ and _AHB_ sinks.
> +uart4: serial at 80010000 {
> +	compatible = "alphascale,asm9260-uart";
> +	reg = <0x80010000 0x4000>;
> +	clocks = <&acc CLKID_SYS_UART4>, <&acc CLKID_AHB_UART4>;
> +	interrupts = <19>;
> +	status = "disabled";
> +};
> +
> +Clock consumer with only one, _AHB_ sink.
> +timer0: timer at 80088000 {
> +	compatible = "alphascale,asm9260-timer";
> +	reg = <0x80088000 0x4000>;
> +	clocks = <&acc CLKID_AHB_TIMER0>;
> +	interrupts = <29>;
> +};
> +
> -- 
> 1.9.1
> 
> 
