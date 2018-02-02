From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 2 Feb 2018 20:49:35 +0100
Subject: [PATCH 2/3] ARM: dts: sun8i: add audio codec support into V3s DTSI
In-Reply-To: <20180202140153.21549-3-icenowy@aosc.io>
References: <20180202140153.21549-1-icenowy@aosc.io>
 <20180202140153.21549-3-icenowy@aosc.io>
Message-ID: <20180202194935.vdqkgch6mowqi2px@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 02, 2018 at 10:01:52PM +0800, Icenowy Zheng wrote:
> Allwinner V3s SoC features an internal audio codec like the one in H3,
> and a analog codec like the one in H3/A23 (but much simpler).
> 
> Add them in the DTSI file.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm/boot/dts/sun8i-v3s.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
> index 20edebd983f0..f6c534efaef9 100644
> --- a/arch/arm/boot/dts/sun8i-v3s.dtsi
> +++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
> @@ -354,6 +354,25 @@
>  			status = "disabled";
>  		};
>  
> +		codec: codec at 01c22c00 {
> +			#sound-dai-cells = <0>;
> +			compatible = "allwinner,sun8i-v3s-codec";
> +			reg = <0x01c22c00 0x400>;
> +			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
> +			clock-names = "apb", "codec";
> +			resets = <&ccu RST_BUS_CODEC>;
> +			dmas = <&dma 15>, <&dma 15>;
> +			dma-names = "rx", "tx";
> +			allwinner,codec-analog-controls = <&codec_analog>;
> +			status = "disabled";
> +		};
> +
> +		codec_analog: codec-analog at 01c23000 {
> +			compatible = "allwinner,sun8i-v3s-codec-analog";
> +			reg = <0x01c23000 0x4>;

This should be the whole size of the memory region.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180202/f42707f9/attachment.sig>
