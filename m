From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 02 Jan 2018 16:11:25 +0100
Subject: [PATCH] arm64: dts: marvell: armada-37xx: add a crypto node
In-Reply-To: <20171226161653.4601-1-antoine.tenart@free-electrons.com>
 (Antoine Tenart's message of "Tue, 26 Dec 2017 17:16:53 +0100")
References: <20171226161653.4601-1-antoine.tenart@free-electrons.com>
Message-ID: <87a7xwcn36.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,
 
 On mar., d?c. 26 2017, Antoine Tenart <antoine.tenart@free-electrons.com> wrote:

> This patch adds a crypto node describing the EIP97 engine found in
> Armada 37xx SoCs. The cryptographic engine is enabled by default.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index 90c26d616a54..4c4b7a2fb162 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -309,6 +309,20 @@
>  				};
>  			};
>  
> +			crypto: crypto at 90000 {
> +				compatible = "inside-secure,safexcel-eip97";
> +				reg = <0x90000 0x20000>;
> +				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-names = "mem", "ring0", "ring1",
> +						  "ring2", "ring3", "eip";
> +				clocks = <&nb_periph_clk 15>;
> +			};
> +
>  			sdhci1: sdhci at d0000 {
>  				compatible = "marvell,armada-3700-sdhci",
>  					     "marvell,sdhci-xenon";
> -- 
> 2.14.3
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
