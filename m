From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 2 Feb 2018 20:48:46 +0100
Subject: [PATCH 1/3] ARM: dts: sun8i: add DMA engine in V3s DTSI
In-Reply-To: <20180202140153.21549-2-icenowy@aosc.io>
References: <20180202140153.21549-1-icenowy@aosc.io>
 <20180202140153.21549-2-icenowy@aosc.io>
Message-ID: <20180202194846.eb7vm4t2cy4kwdfo@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Feb 02, 2018 at 10:01:51PM +0800, Icenowy Zheng wrote:
> Allwinner V3s SoC features a DMA engine.
> 
> Add it in the DTSI file.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm/boot/dts/sun8i-v3s.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
> index 443b083c6adc..20edebd983f0 100644
> --- a/arch/arm/boot/dts/sun8i-v3s.dtsi
> +++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
> @@ -178,6 +178,15 @@
>  		};
>  
>

You have on extra line here

> +		dma: dma-controller at 01c02000 {

The leading 0 will generate a DT warning

> +			compatible = "allwinner,sun8i-v3s-dma";
> +			reg = <0x01c02000 0x1000>;
> +			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_DMA>;
> +			resets = <&ccu RST_BUS_DMA>;
> +			#dma-cells = <1>;
> +		};
> +

Since you have that extra line above, you can just drop this new line
here.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180202/aa75cc78/attachment.sig>
