From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 7 Jan 2014 23:38:23 +0100
Subject: [PATCH v2 4/8] arm: dts: sun4i: rename clock node names to clk@N
In-Reply-To: <1388987892-23733-5-git-send-email-wens@csie.org>
References: <1388987892-23733-1-git-send-email-wens@csie.org>
 <1388987892-23733-5-git-send-email-wens@csie.org>
Message-ID: <20140107223823.GH3103@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 06, 2014 at 01:58:08PM +0800, Chen-Yu Tsai wrote:
> Device tree naming conventions state that node names should match
> node function. Change fully functioning clock nodes to match.
> 
> Also add the output name for pll5 to use as the clock name.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index 3ba2b46..45d5283 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -50,42 +50,46 @@
>  			clock-frequency = <0>;
>  		};
>  
> -		osc24M: osc24M at 01c20050 {
> +		osc24M: clk at 01c20050 {
>  			#clock-cells = <0>;
>  			compatible = "allwinner,sun4i-osc-clk";
>  			reg = <0x01c20050 0x4>;
>  			clock-frequency = <24000000>;
> +			clock-output-names = "osc24M";
>  		};
>  
> -		osc32k: osc32k {
> +		osc32k: clk at 0 {
>  			#clock-cells = <0>;
>  			compatible = "fixed-clock";
>  			clock-frequency = <32768>;
> +			clock-output-names = "osc32k";
>  		};
>  
> -		pll1: pll1 at 01c20000 {
> +		pll1: clk at 01c20000 {
>  			#clock-cells = <0>;
>  			compatible = "allwinner,sun4i-pll1-clk";
>  			reg = <0x01c20000 0x4>;
>  			clocks = <&osc24M>;
> +			clock-output-names = "pll1";
>  		};
>  
> -		pll4: pll4 at 01c20018 {
> +		pll4: clk at 01c20018 {
>  			#clock-cells = <0>;
>  			compatible = "allwinner,sun4i-pll1-clk";
>  			reg = <0x01c20018 0x4>;
>  			clocks = <&osc24M>;
> +			clock-output-names = "pll4";
>  		};
>  
> -		pll5: pll5 at 01c20020 {
> +		pll5: clk at 01c20020 {
>  			#clock-cells = <1>;
>  			compatible = "allwinner,sun4i-pll5-clk";
>  			reg = <0x01c20020 0x4>;
>  			clocks = <&osc24M>;
> -			clock-output-names = "pll5_ddr", "pll5_other";
> +			clock-output-names = "pll5_ddr", "pll5_other", "pll5";

Hmmm, I don't really like that bit too much.

This "pll5" clock doesn't actually exist at the hardware point of
view, which is not really what the DT is used for.

I can think of two ways to do what you want withouth this: 
  - either hardcode the name, since we have a compatible of our own here
  - or use strchr to take anyhing until '_' and use that as a name


-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140107/3f84527b/attachment.sig>
