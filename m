From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Sun, 23 Apr 2017 23:56:16 +0000
Subject: [PATCH 1/5] arm64: renesas: r8a7796: Add external audio clocks
In-Reply-To: <1492779321-23939-2-git-send-email-geert+renesas@glider.be>
References: <1492779321-23939-1-git-send-email-geert+renesas@glider.be>
 <1492779321-23939-2-git-send-email-geert+renesas@glider.be>
Message-ID: <8760huwulb.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Geert

> Add the external audio clocks as zero Hz fixed-frequency clocks.
> Boards that provide these clocks should override them.
> 
> Based on commit 623197b90c7aa97c ("arm64: renesas: r8a7795: Sound SSI
> PIO support").
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

>  arch/arm64/boot/dts/renesas/r8a7796.dtsi | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> index 2ec1ed5f499165ad..101cd41d693a7ab5 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> @@ -120,6 +120,29 @@
>  		clock-frequency = <0>;
>  	};
>  
> +	/*
> +	 * The external audio clocks are configured as 0 Hz fixed frequency
> +	 * clocks by default.
> +	 * Boards that provide audio clocks should override them.
> +	 */
> +	audio_clk_a: audio_clk_a {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <0>;
> +	};
> +
> +	audio_clk_b: audio_clk_b {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <0>;
> +	};
> +
> +	audio_clk_c: audio_clk_c {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <0>;
> +	};
> +
>  	/* External CAN clock - to be overridden by boards that provide it */
>  	can_clk: can {
>  		compatible = "fixed-clock";
> -- 
> 2.7.4
> 
