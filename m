From: katsuhiro@katsuster.net (Katsuhiro Suzuki)
Date: Tue, 11 Sep 2018 01:12:03 +0900
Subject: [PATCH] arm64: dts: rockchip: add i2s and spdif endpoints of
 rk3328
In-Reply-To: <20180910161011.613-1-katsuhiro@katsuster.net>
References: <20180910161011.613-1-katsuhiro@katsuster.net>
Message-ID: <8acd8c0d-0185-e9b4-160b-0d406c0fa7ac@katsuster.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ugh, sorry. I got mistake.
This is 'v2' patch.

On 2018?09?11? 01:10, Katsuhiro Suzuki wrote:
> This patch adds port and endpoint of i2s and spdif nodes for rk3328.
> Because to use modern sound card interface such as audio-graph-card.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>   arch/arm64/boot/dts/rockchip/rk3328.dtsi | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index d3ef6566325e..fd35dbd37ee2 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -179,7 +179,13 @@
>   		clock-names = "i2s_clk", "i2s_hclk";
>   		dmas = <&dmac 11>, <&dmac 12>;
>   		dma-names = "tx", "rx";
> +		#sound-dai-cells = <0>;
>   		status = "disabled";
> +
> +		i2s0_p0: port {
> +			i2s0_p0_0: endpoint {
> +			};
> +		};
>   	};
>   
>   	i2s1: i2s at ff010000 {
> @@ -190,7 +196,13 @@
>   		clock-names = "i2s_clk", "i2s_hclk";
>   		dmas = <&dmac 14>, <&dmac 15>;
>   		dma-names = "tx", "rx";
> +		#sound-dai-cells = <0>;
>   		status = "disabled";
> +
> +		i2s1_p0: port {
> +			i2s1_p0_0: endpoint {
> +			};
> +		};
>   	};
>   
>   	i2s2: i2s at ff020000 {
> @@ -201,7 +213,13 @@
>   		clock-names = "i2s_clk", "i2s_hclk";
>   		dmas = <&dmac 0>, <&dmac 1>;
>   		dma-names = "tx", "rx";
> +		#sound-dai-cells = <0>;
>   		status = "disabled";
> +
> +		i2s2_p0: port {
> +			i2s2_p0_0: endpoint {
> +			};
> +		};
>   	};
>   
>   	spdif: spdif at ff030000 {
> @@ -214,7 +232,13 @@
>   		dma-names = "tx";
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&spdifm2_tx>;
> +		#sound-dai-cells = <0>;
>   		status = "disabled";
> +
> +		spdif_p0: port {
> +			spdif_p0_0: endpoint {
> +			};
> +		};
>   	};
>   
>   	pdm: pdm at ff040000 {
> 
