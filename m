From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Jul 2014 15:22:45 +0200
Subject: [RFC 6/8] ARM: sunxi: Add PLL2 support
In-Reply-To: <1406519386-4902-7-git-send-email-emilio@elopez.com.ar>
References: <1406519386-4902-1-git-send-email-emilio@elopez.com.ar>
 <1406519386-4902-7-git-send-email-emilio@elopez.com.ar>
Message-ID: <20140728132245.GL3952@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 12:49:44AM -0300, Emilio L?pez wrote:
> This commit adds the PLL2 definition to the sun4i, sun5i and sun7i
> device trees. PLL2 is used to clock audio devices.
> 
> Not-signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> ---
> 
> Note that there is no handling of A10 rev A here, this should not go 
> in as-is.
> 
>  arch/arm/boot/dts/sun4i-a10.dtsi  | 8 ++++++++
>  arch/arm/boot/dts/sun5i-a10s.dtsi | 8 ++++++++
>  arch/arm/boot/dts/sun5i-a13.dtsi  | 8 ++++++++
>  arch/arm/boot/dts/sun7i-a20.dtsi  | 8 ++++++++
>  4 files changed, 32 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index faf41e3..7671e56 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -81,6 +81,14 @@
>  			clock-output-names = "pll1";
>  		};
>  
> +		pll2: clk at 01c20008 {
> +			#clock-cells = <1>;
> +			compatible = "allwinner,sun4i-a10-b-pll2-clk";
> +			reg = <0x01c20008 0x4>;
> +			clocks = <&osc24M>;
> +			clock-output-names = "pll2", "pll2x2", "pll2x4", "pll2x8";

Why don't you just declare the fixed factors as fixed factors? It
would simplify greatly your driver, and be more accurate.

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140728/699da049/attachment-0001.sig>
