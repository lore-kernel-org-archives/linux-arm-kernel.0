From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 15 Feb 2018 09:21:17 +0100
Subject: [PATCH] ARM64: dts: allwinner: sun50i-h5-orangepi-zero-plus2:
 rename mmc0_pins_a to mmc0_pins
In-Reply-To: <1518598487-29201-1-git-send-email-clabbe@baylibre.com>
References: <1518598487-29201-1-git-send-email-clabbe@baylibre.com>
Message-ID: <20180215082117.rggaheb2k47azkgi@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 14, 2018 at 08:54:47AM +0000, Corentin Labbe wrote:
> mmc0_pins_a were renamed in arch/arm but not in arch/arm64 resulting in
> a build failure.
> 
> Fixes: 813f2c8fa119 ("ARM: dts: sunxi: h3-h5: rename mmc0_pins_a and mmc1_pins_a")
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
> index feee125a4e9a..87c1a0dace5f 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
> @@ -82,7 +82,7 @@
>  
>  &mmc1 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc1_pins_a>;
> +	pinctrl-0 = <&mmc1_pins>;

The actual issue was that the commit 4db86a4b103e ("ARM: dts: sunxi:
h3-h5: Move pinctrl of mmc1 from dts to dtsi") didn't remove the node
in that DTS.

I've amended it.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180215/8c2094fd/attachment-0001.sig>
