From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Dec 2017 08:47:14 +0100
Subject: [PATCH 4/5] arm: dts: sun8i: a83t: Add support for the ir
 interface
In-Reply-To: <20171217224547.21481-5-embed3d@gmail.com>
References: <20171217224547.21481-1-embed3d@gmail.com>
 <20171217224547.21481-5-embed3d@gmail.com>
Message-ID: <20171218074714.ei4cuvl3ydc72zev@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 17, 2017 at 11:45:46PM +0100, Philipp Rossak wrote:
> The ir interface is like on the H3 located at 0x01f02000 and is exactly
> the same. This patch adds support for the ir interface on the A83T.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> index 954c2393325f..9e7ed3b9a6b8 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -503,6 +503,16 @@
>  			#reset-cells = <1>;
>  		};
>  
> +		ir: ir at 01f02000 {
> +			compatible = "allwinner,sun5i-a13-ir";
> +			clocks = <&r_ccu CLK_APB0_IR>, <&r_ccu CLK_IR>;
> +			clock-names = "apb", "ir";
> +			resets = <&r_ccu RST_APB0_IR>;
> +			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> +			reg = <0x01f02000 0x40>;

The size should be the size of the whole memory block, not just the
registers you need.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171218/f0fc4225/attachment-0001.sig>
