From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Sat, 25 Feb 2017 17:38:03 +0100
Subject: [PATCH] arm64: dts: allwinner: add support for Pinebook
In-Reply-To: <20170225070032.35834-1-icenowy@aosc.xyz>
References: <20170225070032.35834-1-icenowy@aosc.xyz>
Message-ID: <20170225163802.guxwxzp734hlqoob@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 25, 2017 at 03:00:32PM +0800, Icenowy Zheng wrote:
[...]
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> new file mode 100644
> index 000000000000..2dceba3132b0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
[...]
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +
> +		lid_switch {

Node names should not contain underscores. You can use hyphens instead. See
https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1122967.html
https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1145633.html

> +&mmc0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc0_pins>;
> +	vmmc-supply = <&reg_vcc3v3>;
> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
> +	cd-inverted;

You ought to be able to replace those last two lines with just
cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;

> +	disable-wp;
> +	bus-width = <4>;
> +	status = "okay";
> +};

-- 
Rask Ingemann Lambertsen
