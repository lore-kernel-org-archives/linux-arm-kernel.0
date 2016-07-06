From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 6 Jul 2016 22:29:32 +0200
Subject: [PATCH -next] ARM: dts: sun8i: Add NFC node to Allwinner A23/A33
 SoC
In-Reply-To: <20160706003352.28194-1-icenowy@aosc.xyz>
References: <20160706003352.28194-1-icenowy@aosc.xyz>
Message-ID: <20160706202932.GD4247@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 06, 2016 at 08:33:52AM +0800, Icenowy Zheng wrote:
> Add NAND Flash controller node definition to the A23/A33 SoC.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Has this ever been tested? On what board, with what NAND chip?

> ---
>  arch/arm/boot/dts/sun8i-a23-a33.dtsi | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> index 7e05e09..270c38a 100644
> --- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> @@ -209,6 +209,14 @@
>  					"apb2_uart3", "apb2_uart4";
>  		};
>  
> +		nand_clk: clk at 01c20080 {
> +			#clock-cells = <0>;
> +			compatible = "allwinner,sun4i-a10-mod0-clk";
> +			reg = <0x01c20080 0x4>;
> +			clocks = <&osc24M>, <&pll6 1>;
> +			clock-output-names = "nand";
> +		};
> +

This should be in a separate patch.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160706/0e612818/attachment.sig>
