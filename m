From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 17 Sep 2018 12:47:17 +0200
Subject: [PATCH v2] arm64: dts: rockchip: add i2s and spdif endpoints of
 rk3328
In-Reply-To: <20180917085555.21775-1-katsuhiro@katsuster.net>
References: <20180917085555.21775-1-katsuhiro@katsuster.net>
Message-ID: <9920488.EWSIgOMfRJ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Montag, 17. September 2018, 10:55:55 CEST schrieb Katsuhiro Suzuki:
> This patch adds port and endpoint of i2s and spdif nodes for rk3328.
> Because to use modern sound card interface such as audio-graph-card.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index d3ef6566325e..fd35dbd37ee2 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -179,7 +179,13 @@
>  		clock-names = "i2s_clk", "i2s_hclk";
>  		dmas = <&dmac 11>, <&dmac 12>;
>  		dma-names = "tx", "rx";
> +		#sound-dai-cells = <0>;
>  		status = "disabled";
> +
> +		i2s0_p0: port {
> +			i2s0_p0_0: endpoint {
> +			};
> +		};

I'm still pondering this. I.e. I'm not sure I really like adding all these
empty nodes only to have them filled in board devicetrees.

This is specific to the audio-graph-card, and neither simple-audio-card
nor the Rockchip-specific cards we have use something like this, so
currently I'm tending to just have all audio-graph-nodes defined in the
board devicetree using it.

For example similar to arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
or zte/zx296718-pcbox.dts do it.

It would be different if the graph-links were actually on the soc-level
like vop<->hdmi or so, but this is completely board-specific.

Same for the others below.

Thoughts?
Heiko


>  	};
>  
>  	i2s1: i2s at ff010000 {
> @@ -190,7 +196,13 @@
>  		clock-names = "i2s_clk", "i2s_hclk";
>  		dmas = <&dmac 14>, <&dmac 15>;
>  		dma-names = "tx", "rx";
> +		#sound-dai-cells = <0>;
>  		status = "disabled";
> +
> +		i2s1_p0: port {
> +			i2s1_p0_0: endpoint {
> +			};
> +		};
>  	};
>  
>  	i2s2: i2s at ff020000 {
> @@ -201,7 +213,13 @@
>  		clock-names = "i2s_clk", "i2s_hclk";
>  		dmas = <&dmac 0>, <&dmac 1>;
>  		dma-names = "tx", "rx";
> +		#sound-dai-cells = <0>;
>  		status = "disabled";
> +
> +		i2s2_p0: port {
> +			i2s2_p0_0: endpoint {
> +			};
> +		};
>  	};
>  
>  	spdif: spdif at ff030000 {
> @@ -214,7 +232,13 @@
>  		dma-names = "tx";
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&spdifm2_tx>;
> +		#sound-dai-cells = <0>;
>  		status = "disabled";
> +
> +		spdif_p0: port {
> +			spdif_p0_0: endpoint {
> +			};
> +		};
>  	};
>  
>  	pdm: pdm at ff040000 {
> 
