From: horms@verge.net.au (Simon Horman)
Date: Wed, 28 Nov 2018 13:50:57 +0100
Subject: [PATCH 01/16] ARM: dts: r9a06g032: Add pinctrl node
In-Reply-To: <2b421730228e2ac6e49c3202e4f7ef79a65da71c.1543236456.git.horms+renesas@verge.net.au>
References: <cover.1543236456.git.horms+renesas@verge.net.au>
 <2b421730228e2ac6e49c3202e4f7ef79a65da71c.1543236456.git.horms+renesas@verge.net.au>
Message-ID: <20181128125057.dwf7qae323yv64ma@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2018 at 01:54:03PM +0100, Simon Horman wrote:
> From: Phil Edworthy <phil.edworthy@renesas.com>
> 
> This provides a pinctrl driver for the Renesas R9A06G032 SoC
> 
> Based on a patch originally written by Michel Pollet at Renesas.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> Geert Uytterhoeven <geert+renesas@glider.be>

The tag above is garbled. I will fix this and repost this pull-request.

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/boot/dts/r9a06g032.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
> index eaf94976ed6d..2322268bc862 100644
> --- a/arch/arm/boot/dts/r9a06g032.dtsi
> +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> @@ -165,6 +165,14 @@
>  			status = "disabled";
>  		};
>  
> +		pinctrl: pin-controller at 40067000 {
> +			compatible = "renesas,r9a06g032-pinctrl", "renesas,rzn1-pinctrl";
> +			reg = <0x40067000 0x1000>, <0x51000000 0x480>;
> +			clocks = <&sysctrl R9A06G032_HCLK_PINCONFIG>;
> +			clock-names = "bus";
> +			status = "okay";
> +		};
> +
>  		gic: gic at 44101000 {
>  			compatible = "arm,cortex-a7-gic", "arm,gic-400";
>  			interrupt-controller;
> -- 
> 2.11.0
> 
