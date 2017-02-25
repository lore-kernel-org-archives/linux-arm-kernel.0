From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sun, 26 Feb 2017 00:55:06 +0800
Subject: [PATCH] arm64: dts: allwinner: add support for Pinebook
In-Reply-To: <20170225163802.guxwxzp734hlqoob@localhost>
References: <20170225070032.35834-1-icenowy@aosc.xyz>
 <20170225163802.guxwxzp734hlqoob@localhost>
Message-ID: <1242601488041706@web21h.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



26.02.2017, 00:38, "Rask Ingemann Lambertsen" <rask@formelder.dk>:
> On Sat, Feb 25, 2017 at 03:00:32PM +0800, Icenowy Zheng wrote:
> [...]
>> ?diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
>> ?new file mode 100644
>> ?index 000000000000..2dceba3132b0
>> ?--- /dev/null
>> ?+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
>
> [...]
>> ?+ gpio_keys {
>> ?+ compatible = "gpio-keys";
>> ?+
>> ?+ lid_switch {
>
> Node names should not contain underscores. You can use hyphens instead. See
> https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1122967.html
> https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1145633.html

Sorry... but here I modelled after omap3-n900.dts, maybe it should also be changed?

>
>> ?+&mmc0 {
>> ?+ pinctrl-names = "default";
>> ?+ pinctrl-0 = <&mmc0_pins>;
>> ?+ vmmc-supply = <&reg_vcc3v3>;
>> ?+ cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
>> ?+ cd-inverted;
>
> You ought to be able to replace those last two lines with just
> cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;

Before this all Allwinner boards uses GPIO_ACTIVE_HIGH and
cd-inverted.

>
>> ?+ disable-wp;
>> ?+ bus-width = <4>;
>> ?+ status = "okay";
>> ?+};
>
> --
> Rask Ingemann Lambertsen
