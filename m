From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 4 May 2018 17:09:28 +0200
Subject: [PATCH 4/7] arm64: allwinner: h6: add node for R_PIO pin
 controller
In-Reply-To: <20180503183847.11046-5-icenowy@aosc.io>
References: <20180503183847.11046-1-icenowy@aosc.io>
 <20180503183847.11046-5-icenowy@aosc.io>
Message-ID: <20180504150928.252mifsr533j6kvr@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2018 at 02:38:44AM +0800, Icenowy Zheng wrote:
> Allwinner H6 SoC has a R_PIO pin controller which controls PL and PM
> GPIO banks.
> 
> Add support for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index db9da343ba46..a18b78fb4850 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -183,5 +183,18 @@
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
>  		};
> +
> +		r_pio: pinctrl at 7022000 {
> +			compatible = "allwinner,sun50i-h6-r-pinctrl";
> +			reg = <0x07022000 0x400>;
> +			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&r_ccu CLK_R_APB1>, <&osc24M>, <&osc32k>;

As usual, try not to use the indices you introduce in the previous
patches of your serie. This introduces a dependency between the clk
and arm-soc tree that is not easy to deal with.

changed for the raw index, and applied, thanks!
maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180504/d03e455a/attachment.sig>
