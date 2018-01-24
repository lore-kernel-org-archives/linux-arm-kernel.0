From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 24 Jan 2018 12:02:22 +0100
Subject: [linux-sunxi][PATCH 5/5] arm64: allwinner: a64: Add DAI nodes
In-Reply-To: <20180124103943.2062-6-codekipper@gmail.com>
References: <20180124103943.2062-1-codekipper@gmail.com>
 <20180124103943.2062-6-codekipper@gmail.com>
Message-ID: <20180124110222.cdglyg5m7644xiem@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 24, 2018 at 11:39:43AM +0100, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> Add the DAI blocks to the device tree. I2S0 and I2S1 are for
> connecting to an external codec.
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index f060a58f374c..f3354f8c2026 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -419,6 +419,32 @@
>  			status = "disabled";
>  		};
>  
> +		i2s0: i2s at 1c22000 {
> +			#sound-dai-cells = <0>;
> +			compatible = "allwinner,sun8i-h3-i2s";

Same remark than for the spdif, please add a soc-specific compatible.

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
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180124/768252f6/attachment.sig>
