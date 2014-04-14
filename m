From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 14 Apr 2014 12:44:09 +0200
Subject: [PATCH 16/29] ARM: orion5x: enable pinctrl driver at SoC level
In-Reply-To: <1397400006-4315-17-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-17-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <534BBBF9.60903@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/2014 04:39 PM, Thomas Petazzoni wrote:
> This commit declares the pinctrl device in the Orion5x 5182 Device
> Tree files, and ensures that the Orion pinctrl driver is compiled.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>   arch/arm/boot/dts/orion5x-mv88f5182.dtsi | 5 +++++
>   arch/arm/mach-orion5x/Kconfig            | 2 ++
>   2 files changed, 7 insertions(+)
>
> diff --git a/arch/arm/boot/dts/orion5x-mv88f5182.dtsi b/arch/arm/boot/dts/orion5x-mv88f5182.dtsi
> index a56f9c8..11b487c 100644
> --- a/arch/arm/boot/dts/orion5x-mv88f5182.dtsi
> +++ b/arch/arm/boot/dts/orion5x-mv88f5182.dtsi
> @@ -15,6 +15,11 @@
>   		compatible = "marvell,orion5x-88f5182-mbus", "simple-bus";
>
>   		internal-regs {
> +			pinctrl at 10000 {

Please add a node label.

Otherwise,

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> +				compatible = "marvell,88f5182-pinctrl";
> +				reg = <0x10000 0x8>, <0x10050 0x4>;
> +			};
> +
>   			core_clk: core-clocks at 10030 {
>   				compatible = "marvell,mv88f5182-core-clock";
>   				reg = <0x10010 0x4>;
> diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
> index bd65872..3c69a3c 100644
> --- a/arch/arm/mach-orion5x/Kconfig
> +++ b/arch/arm/mach-orion5x/Kconfig
> @@ -8,6 +8,8 @@ config ARCH_ORION5X_DT
>   	select ORION_CLK
>   	select ORION_IRQCHIP
>   	select ORION_TIMER
> +	select PINCTRL
> +	select PINCTRL_ORION
>   	help
>   	  Say 'Y' here if you want your kernel to support the
>   	  Marvell Orion5x using flattened device tree.
>
