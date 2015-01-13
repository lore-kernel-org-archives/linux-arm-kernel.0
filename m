From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 13 Jan 2015 16:44:15 +0100
Subject: [PATCH] ARM: dts: sun6i: Convert hummingbird a31 dts to label
 references
In-Reply-To: <1421123484-21387-1-git-send-email-wens@csie.org>
References: <1421123484-21387-1-git-send-email-wens@csie.org>
Message-ID: <20150113154415.GY4891@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 13, 2015 at 12:31:24PM +0800, Chen-Yu Tsai wrote:
> Using label references is preferred when override settings from the
> included dtsi.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> My AXP221 series touches this file. I thought I'd convert it first.
> 
> This looks like a lot of changes. But if you filter out all the
> indentation changes, it's just the opening lines for each node.
> 
> ---
>  arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 181 ++++++++++++++--------------
>  1 file changed, 88 insertions(+), 93 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> index ebd5f7854b1b..97dbaeb76416 100644
> --- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> +++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> @@ -61,101 +61,96 @@
>  	chosen {
>  		bootargs = "earlyprintk console=ttyS0,115200";
>  	};
> +};
> +
> +&mmc0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_hummingbird>;
> +	vmmc-supply = <&reg_vcc3v0>;
> +	bus-width = <4>;
> +	cd-gpios = <&pio 0 8 GPIO_ACTIVE_HIGH>; /* PA8 */
> +	cd-inverted;
> +	status = "okay";
> +};
> +
> +&usbphy {
> +	usb1_vbus-supply = <&reg_usb1_vbus>;
> +	status = "okay";
> +};
> +
> +&ehci0 {
> +	status = "okay";
> +};
> +
> +&ohci0 {
> +	status = "okay";
> +};
> +
> +&pio {
> +	mmc0_cd_pin_hummingbird: mmc0_cd_pin at 0 {
> +		allwinner,pins = "PA8";
> +		allwinner,function = "gpio_in";
> +		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
> +	};
> +};
> +
> +&mmc0_pins_a {
> +	/* external pull-ups missing for some pins */
> +	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
> +};
> +
> +&usb1_vbus_pin_a {
> +	/* different pin from sunxi-common-regulators */
> +	allwinner,pins = "PH24";
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pins_a>;
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_pins_a>;
> +	/* pull-ups and devices require AXP221 DLDO3 */
> +	status = "failed";
> +};

I think we should define a convention about how to sort these nodes
before we actually start merging some of it.

This of course also apply to the other patches doing that, hence why
Hans is CC'd.

I guess sorting them by label alphabetical order would make
sense. What do you think?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150113/928f1484/attachment-0001.sig>
