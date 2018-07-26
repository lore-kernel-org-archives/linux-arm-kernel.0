From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 26 Jul 2018 09:34:58 +0200
Subject: [PATCH v2 03/18] arm64: dts: allwinner: a64: Orange Pi Win: Fix
 SD card node
In-Reply-To: <20180726003532.18751-4-andre.przywara@arm.com>
References: <20180726003532.18751-1-andre.przywara@arm.com>
 <20180726003532.18751-4-andre.przywara@arm.com>
Message-ID: <20180726073458.3zy2r6hxpeu46wsc@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 01:35:17AM +0100, Andre Przywara wrote:
> From: Samuel Holland <samuel@sholland.org>
> 
> The Orange Pi Win has an microSD card slot, which is connected via all
> four SD data lines. Also microSD does not have a write protect switch,
> so disable this feature in the DT node.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> index 1221764f5719..667016815cf3 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> @@ -67,7 +67,9 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc0_pins>;
>  	vmmc-supply = <&reg_dcdc1>;
> -	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
> +	disable-wp;
> +	bus-width = <4>;

This patch claims that it's fixing things, but it's not said anywhere
what it is fixing exactly.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180726/d823303d/attachment-0001.sig>
