From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 26 Feb 2017 01:03:17 +0800
Subject: [linux-sunxi] Re: [PATCH] arm64: dts: allwinner: add support for
 Pinebook
In-Reply-To: <1242601488041706@web21h.yandex.ru>
References: <20170225070032.35834-1-icenowy@aosc.xyz>
 <20170225163802.guxwxzp734hlqoob@localhost>
 <1242601488041706@web21h.yandex.ru>
Message-ID: <CAGb2v650PAJU9HCbEFLYt3EeMW7T2ZxOJ0pfMSvQR_18Om2p+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 26, 2017 at 12:55 AM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
>
>
> 26.02.2017, 00:38, "Rask Ingemann Lambertsen" <rask@formelder.dk>:
>> On Sat, Feb 25, 2017 at 03:00:32PM +0800, Icenowy Zheng wrote:
>> [...]
>>>  diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
>>>  new file mode 100644
>>>  index 000000000000..2dceba3132b0
>>>  --- /dev/null
>>>  +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
>>
>> [...]
>>>  + gpio_keys {
>>>  + compatible = "gpio-keys";
>>>  +
>>>  + lid_switch {
>>
>> Node names should not contain underscores. You can use hyphens instead. See
>> https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1122967.html
>> https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1145633.html
>
> Sorry... but here I modelled after omap3-n900.dts, maybe it should also be changed?

I believe this is a recent change to the device tree compiler. (Or maybe not.)
Either way underscores in node names will give out warnings if they are turned
on. While they aren't at the moment, it does not mean it's OK to add even
more.

Old DTs may have them. It may be up to the respective maintainers to fix them.
Or there might be some code that depends on the names being how they currently
are, which means they can't be changed easily.

>
>>
>>>  +&mmc0 {
>>>  + pinctrl-names = "default";
>>>  + pinctrl-0 = <&mmc0_pins>;
>>>  + vmmc-supply = <&reg_vcc3v3>;
>>>  + cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
>>>  + cd-inverted;
>>
>> You ought to be able to replace those last two lines with just
>> cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
>
> Before this all Allwinner boards uses GPIO_ACTIVE_HIGH and
> cd-inverted.

This might be some leftover stuff from before gpios supported flags.
IIRC the mmc core supports both, so dropping cd-inverted and using
GPIO_ACTIVE_LOW should be fine.

Documentation/devicetree/bindings/mmc/mmc.txt explains this.

ChenYu

>>
>>>  + disable-wp;
>>>  + bus-width = <4>;
>>>  + status = "okay";
>>>  +};
>>
>> --
>> Rask Ingemann Lambertsen
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
