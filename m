From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 03 Jan 2017 16:14:15 +0100
Subject: [PATCH v4 3/4] arm64: dts: marvell: Add definition of SPI
 controller for Armada 3700
In-Reply-To: <20161208145847.7794-4-romain.perier@free-electrons.com> (Romain
 Perier's message of "Thu, 8 Dec 2016 15:58:46 +0100")
References: <20161208145847.7794-1-romain.perier@free-electrons.com>
 <20161208145847.7794-4-romain.perier@free-electrons.com>
Message-ID: <87lgusgoqg.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Romain,
 
 On jeu., d?c. 08 2016, Romain Perier <romain.perier@free-electrons.com> wrote:

> Armada 3700 SoC has an SPI Controller, this commit adds the definition
> of the SPI device node at the SoC level.
>
> Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
> Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied on mvebu/dt64

Thanks,

Gregory
> ---
>
> Changes in v3:
>  - Fixed wrong register size for spi0, as suggested by the maintainer
>    on the ML.
>  - Added tag "Tested-by" by Gregory
>
> Changes in v2:
>  - Removed properties max-frequency and clock-frequency, it is no
>    longer required and not used by the DT-bindings.
>
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index e9bd587..fcef9a5 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -98,6 +98,17 @@
>  			/* 32M internal register @ 0xd000_0000 */
>  			ranges = <0x0 0x0 0xd0000000 0x2000000>;
>  
> +			spi0: spi at 10600 {
> +				compatible = "marvell,armada-3700-spi";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0x10600 0xA00>;
> +				clocks = <&nb_periph_clk 7>;
> +				interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +				num-cs = <4>;
> +				status = "disabled";
> +			};
> +
>  			uart0: serial at 12000 {
>  				compatible = "marvell,armada-3700-uart";
>  				reg = <0x12000 0x400>;
> -- 
> 2.9.3
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
