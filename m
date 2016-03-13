From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 13 Mar 2016 22:50:43 +0100
Subject: [linux-sunxi][PATCH 3/5] ARM: dts: sunxi: Add the SPDIF to the
 A10 and A20
In-Reply-To: <1456589909-2428-4-git-send-email-codekipper@gmail.com>
References: <1456589909-2428-1-git-send-email-codekipper@gmail.com>
 <1456589909-2428-4-git-send-email-codekipper@gmail.com>
Message-ID: <20160313215043.GJ8418@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Feb 27, 2016 at 05:18:27PM +0100, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> Add the SPDIF transceiver controller and clock to the A10 and
> A20 dtsi.
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 23 +++++++++++++++++++++++
>  arch/arm/boot/dts/sun7i-a20.dtsi | 23 +++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index 0483640..83d46b2 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -477,6 +477,17 @@
>  			clock-output-names = "ir1";
>  		};
>  
> +		spdif_clk: clk at 01c200c0 {
> +			#clock-cells = <0>;
> +			compatible = "allwinner,sun4i-a10-mod1-clk";
> +			reg = <0x01c200c0 0x4>;
> +			clocks = <&pll2 SUN4I_A10_PLL2_8X>,
> +				 <&pll2 SUN4I_A10_PLL2_4X>,
> +				 <&pll2 SUN4I_A10_PLL2_2X>,
> +				 <&pll2 SUN4I_A10_PLL2_1X>;
> +			clock-output-names = "spdif";
> +		};
> +
>  		usb_clk: clk at 01c200cc {
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
> @@ -1055,6 +1066,18 @@
>  			status = "disabled";
>  		};
>  
> +		spdif: spdif at 01c21000 {
> +			#sound-dai-cells = <0>;
> +			compatible = "allwinner,sun4i-a10-spdif";
> +			reg = <0x01c21000 0x40>;

It only takes 64 bytes?

> +			interrupts = <13>;
> +			clocks = <&apb0_gates 1>, <&spdif_clk>;
> +			clock-names = "apb", "spdif";
> +			dmas = <&dma 0 2>, <&dma 0 2>;

Please use the defines here.

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
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160313/1fc0332b/attachment-0001.sig>
