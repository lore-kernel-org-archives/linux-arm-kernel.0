From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 4 May 2016 20:32:06 +0200
Subject: [PATCH 1/2] ARM: sun4i: dt: Add pll3 and pll7 clocks
In-Reply-To: <1462295659-6945-2-git-send-email-plaes@plaes.org>
References: <1462295659-6945-1-git-send-email-plaes@plaes.org>
 <1462295659-6945-2-git-send-email-plaes@plaes.org>
Message-ID: <20160504183206.GC17159@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, May 03, 2016 at 08:14:18PM +0300, Priit Laes wrote:
> Enable pll3 and pll7 clocks that are needed to drive display clocks.
> 
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 44 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index 268a150..c893744 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -184,6 +184,15 @@
>  			clock-output-names = "osc24M";
>  		};
>  
> +		osc3M: osc3M_clk {
> +			compatible = "fixed-factor-clock";
> +			#clock-cells = <0>;
> +			clock-div = <8>;
> +			clock-mult = <1>;
> +			clocks = <&osc24M>;
> +			clock-output-names = "osc3M";
> +		};
> +
>  		osc32k: clk at 0 {
>  			#clock-cells = <0>;
>  			compatible = "fixed-clock";
> @@ -208,6 +217,24 @@
>  					     "pll2-4x", "pll2-8x";
>  		};
>  
> +		pll3: clk at 01c20010 {
> +			#clock-cells = <0>;
> +			compatible = "allwinner,sun4i-a10-pll3-clk";
> +			reg = <0x01c20010 0x4>;
> +			clocks = <&osc3M>;
> +			clock-output-names = "pll3";
> +		};
> +
> +		pll3x2: pll3x2_clk {
> +			compatible = "fixed-factor-clock";
> +			#clock-cells = <0>;
> +			clock-div = <1>;
> +			clock-mult = <2>;
> +			clocks = <&pll3>;
> +			clock-output-names = "pll3-x2";

We usually call them -2x

> +		};
> +
> +

One newline too many.

Fixed it and applied the patch.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160504/7f876d71/attachment-0001.sig>
