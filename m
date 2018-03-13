From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 13 Mar 2018 09:27:24 +0100
Subject: [PATCH 3/5] arm64: dts: allwinner: a64: add simplefb for A64 SoC
In-Reply-To: <20180312161050.7647-4-harald@ccbib.org>
References: <20180312161050.7647-1-harald@ccbib.org>
 <20180312161050.7647-4-harald@ccbib.org>
Message-ID: <20180313082724.7optc2xwgqoiibtx@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2018 at 04:10:48PM +0000, Harald Geyer wrote:
> The A64 SoC features two display pipelines, one has a LCD output, the
> other has a HDMI output.
> 
> Add support for simplefb for the LCD output. Tested on Teres I.
> 
> This patch was inspired by work of Icenowy Zheng.
> 
> Signed-off-by: Harald Geyer <harald@ccbib.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index ca1b365bc722..05d5e8def68a 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -52,6 +52,26 @@
>  	#address-cells = <1>;
>  	#size-cells = <1>;
>  
> +	chosen {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +/*
> + * The pipeline mixer0-lcd0 depends on clock CLK_MIXER0 from DE2 CCU.
> + * However there is no support for this clock on A64 yet, so we depend
> + * on the upstream clocks here to keep them (and thus CLK_MIXER0) up.
> + */

There's definitely support for the CLK_MIXER0 clock in the DE2 CCU
driver, so I guess this would need to be amended / fixed

Maxime

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180313/62f04321/attachment-0001.sig>
