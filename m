From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Jul 2014 15:25:24 +0200
Subject: [RFC 8/8] ARM: sun7i: Add mod1 clock nodes
In-Reply-To: <1406519386-4902-9-git-send-email-emilio@elopez.com.ar>
References: <1406519386-4902-1-git-send-email-emilio@elopez.com.ar>
 <1406519386-4902-9-git-send-email-emilio@elopez.com.ar>
Message-ID: <20140728132524.GM3952@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 12:49:46AM -0300, Emilio L?pez wrote:
> This commit adds all the mod1 clocks available on A20 to its device
> tree. This list was created by looking at the A20 user manual.
> 
> Not-signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> ---
> 
> As mentioned on an earlier patch, note that this is untested, and I 
> only added them to sun7i. It'd be great if actual users of these clocks 
> could comment :)
> 
>  arch/arm/boot/dts/sun7i-a20.dtsi | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 5d0265a..c57f7ad 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -335,6 +335,29 @@
>  			clock-output-names = "ir1";
>  		};
>  
> +		iis0_clk: clk at 01c200b8 {
> +			#clock-cells = <0>;
> +			compatible = "allwinner,sun4i-a10-mod1-clk";
> +			reg = <0x01c200b8 0x4>;
> +			clocks = <&pll2 0>, <&pll2 1>, <&pll2 2>, <&pll2 3>;
> +			clock-output-names = "iis0";

Usually, it's called i2s.

Otherwise, beside Chen-Yu's comment, it looks fine.

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
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140728/f025e41c/attachment.sig>
