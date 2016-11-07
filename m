From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 7 Nov 2016 19:28:56 +0100
Subject: [PATCH v3 4/6] ARM: dts: sun6i: Add audio codec device node
In-Reply-To: <20161107100703.5586-5-wens@csie.org>
References: <20161107100703.5586-1-wens@csie.org>
 <20161107100703.5586-5-wens@csie.org>
Message-ID: <20161107182856.qbajbuf7jiedllyl@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2016 at 06:07:01PM +0800, Chen-Yu Tsai wrote:
> The A31 SoC includes the Allwinner audio codec, capable of 24-bit
> playback up to 192 kHz and 24-bit capture up to 48 kHz.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun6i-a31.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> index 2e8bf93dcfb2..f68e6102b01b 100644
> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> @@ -784,6 +784,19 @@
>  			reset-names = "ahb";
>  		};
>  
> +		codec: codec at 01c22c00 {
> +			#sound-dai-cells = <0>;
> +			compatible = "allwinner,sun6i-a31-codec";
> +			reg = <0x01c22c00 0x98>;

The memory mapped region is 0x400. I fixed this and applied.

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
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161107/81a10d8c/attachment.sig>
