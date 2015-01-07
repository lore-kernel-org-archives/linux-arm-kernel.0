From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 07 Jan 2015 15:39:02 +0100
Subject: [PATCH v2 1/3] ARM: dts: berlin: add pmu node for BG2Q and BG2CD
In-Reply-To: <1419584281-4811-2-git-send-email-jszhang@marvell.com>
References: <1419584281-4811-1-git-send-email-jszhang@marvell.com>
 <1419584281-4811-2-git-send-email-jszhang@marvell.com>
Message-ID: <54AD4506.6000304@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.12.2014 09:57, Jisheng Zhang wrote:
> This patch adds the pmu node, enabling the PMU unit on Marvell BG2Q and
> BG2CD SoCs.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Applied to berlin/dt.

Thanks!

> ---
>   arch/arm/boot/dts/berlin2cd.dtsi | 5 +++++
>   arch/arm/boot/dts/berlin2q.dtsi  | 8 ++++++++
>   2 files changed, 13 insertions(+)
>
> diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
> index 230df3b..a318bc3 100644
> --- a/arch/arm/boot/dts/berlin2cd.dtsi
> +++ b/arch/arm/boot/dts/berlin2cd.dtsi
> @@ -45,6 +45,11 @@
>
>   		ranges = <0 0xf7000000 0x1000000>;
>
> +		pmu {
> +			compatible = "arm,cortex-a9-pmu";
> +			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
>   		sdhci0: sdhci at ab0000 {
>   			compatible = "mrvl,pxav3-mmc";
>   			reg = <0xab0000 0x200>;
> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> index 35253c9..933dcbb 100644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -63,6 +63,14 @@
>   		ranges = <0 0xf7000000 0x1000000>;
>   		interrupt-parent = <&gic>;
>
> +		pmu {
> +			compatible = "arm,cortex-a9-pmu";
> +			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
>   		sdhci0: sdhci at ab0000 {
>   			compatible = "mrvl,pxav3-mmc";
>   			reg = <0xab0000 0x200>;
>
