From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 16 Apr 2014 15:09:15 +0200
Subject: [PATCH 3/4] ARM: dts: berlin: add the SDHCI nodes for the BG2Q
In-Reply-To: <1397652011-21284-4-git-send-email-antoine.tenart@free-electrons.com>
References: <1397652011-21284-1-git-send-email-antoine.tenart@free-electrons.com>
 <1397652011-21284-4-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140416130915.GC11310@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 02:40:10PM +0200, Antoine T?nart wrote:
> Add the SDHCI nodes for the Marvell Berlin BG2Q, using the berlin-sdhci
> driver.
> 
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> ---
>  arch/arm/boot/dts/berlin2q.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> index 5925e6a16749..8f897d461460 100644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -67,6 +67,14 @@
>  		clock-div = <3>;
>  	};
>  
> +	sdio1clk: sdio1clk {
> +		compatible = "fixed-factor-clock";
> +		#clock-cells = <0>;
> +		clocks = <&syspll>;
> +		clock-mult = <1>;
> +		clock-div = <4>;
> +	};
> +
>  	soc {
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
> @@ -75,6 +83,38 @@
>  		ranges = <0 0xf7000000 0x1000000>;
>  		interrupt-parent = <&gic>;
>  
> +		sdhci0: sdhci at ab0000 {
> +			compatible = "marvell,berlin2q-sdhci";
> +			reg = <0xab0000 0x200>;
> +			clocks = <&sdio1clk>;
> +			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> +			keep-power-in-suspend;
> +			enable-sdio-wakeup;
> +			broken-cd;

Hi Antoine

I would expect these three last properties to be a property of the
board, not the SoC. Or am i missing something?

       Thanks
	Andrew
