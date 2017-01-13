From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 13 Jan 2017 16:29:25 +0100
Subject: [PATCH v2 4/6] arm: dts: mt2701: Add auxadc device node.
In-Reply-To: <1484296978-18572-5-git-send-email-erin.lo@mediatek.com>
References: <1484296978-18572-1-git-send-email-erin.lo@mediatek.com>
 <1484296978-18572-5-git-send-email-erin.lo@mediatek.com>
Message-ID: <341850d0-6f32-9288-4399-96f0d2d00c6f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13/01/17 09:42, Erin Lo wrote:
> From: Zhiyong Tao <zhiyong.tao@mediatek.com>
>
> Add auxadc device node for MT2701.
>
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---
>  arch/arm/boot/dts/mt2701-evb.dts | 4 ++++
>  arch/arm/boot/dts/mt2701.dtsi    | 9 +++++++++
>  2 files changed, 13 insertions(+)
>

Applied to v4.10-next/dts32

> diff --git a/arch/arm/boot/dts/mt2701-evb.dts b/arch/arm/boot/dts/mt2701-evb.dts
> index 879f1eb..a483798 100644
> --- a/arch/arm/boot/dts/mt2701-evb.dts
> +++ b/arch/arm/boot/dts/mt2701-evb.dts
> @@ -24,6 +24,10 @@
>  	};
>  };
>
> +&auxadc {
> +	status = "okay";
> +};
> +
>  &pio {
>  	spi_pins_a: spi0 at 0 {
>  		pins_spi {
> diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
> index 1182c43..4f52019 100644
> --- a/arch/arm/boot/dts/mt2701.dtsi
> +++ b/arch/arm/boot/dts/mt2701.dtsi
> @@ -208,6 +208,15 @@
>  		      <0 0x10216000 0 0x2000>;
>  	};
>
> +	auxadc: adc at 11001000 {
> +		compatible = "mediatek,mt2701-auxadc";
> +		reg = <0 0x11001000 0 0x1000>;
> +		clocks = <&pericfg CLK_PERI_AUXADC>;
> +		clock-names = "main";
> +		#io-channel-cells = <1>;
> +		status = "disabled";
> +	};
> +
>  	uart0: serial at 11002000 {
>  		compatible = "mediatek,mt2701-uart",
>  			     "mediatek,mt6577-uart";
>
