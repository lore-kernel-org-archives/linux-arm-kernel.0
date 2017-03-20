From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 20 Mar 2017 22:30:01 +0800
Subject: [linux-sunxi] [PATCH v3 5/5] ARM: dts: sun8i: h2+: enable USB OTG
 for Orange Pi Zero board
In-Reply-To: <20170320113931.dPmCTite@smtp2h.mail.yandex.net>
References: <20170320113931.dPmCTite@smtp2h.mail.yandex.net>
Message-ID: <CAGb2v644jM_R_4BgRWz7vHTaGwtBC_MSJnppbsQtBKf-qAS2hA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 5:09 PM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
>
> 2017?3?15? 15:16? Chen-Yu Tsai <wens@csie.org>???
>>
>> Hi,
>>
>> On Tue, Mar 7, 2017 at 6:34 AM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
>> > Orange Pi Zero board features a USB OTG port, which has a ID pin, and
>> > can be used to power up the board. However, even if the board is powered
>> > via +5V pin in GPIO/expansion headers, the VBUS in the OTG port cannot
>> > be powered up, thus it's impossible to use it in host mode with simple
>> > OTG cables.
>> >
>> > Add support for it in peripheral mode.
>> >
>> > If someone really want to use it in host mode, the mode of PHY can be
>> > switch via sysfs, then use a powered USB OTG cable or powered USB HUB to
>> > power up external USB devices.
>> >
>> > Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>> > ---
>> > New patch in v3.
>> >
>> >  arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 14 ++++++++++++++
>> >  1 file changed, 14 insertions(+)
>> >
>> > diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
>> > index b7ca916d871d..63f819394b98 100644
>> > --- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
>> > +++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
>> > @@ -96,6 +96,10 @@
>> >         };
>> >  };
>> >
>> > +&ehci0 {
>> > +       status = "okay";
>> > +};
>> > +
>> >  &ehci1 {
>> >         status = "okay";
>> >  };
>> > @@ -132,6 +136,10 @@
>> >         bias-pull-up;
>> >  };
>> >
>> > +&ohci0 {
>> > +       status = "okay";
>> > +};
>> > +
>> >  &ohci1 {
>> >         status = "okay";
>> >  };
>> > @@ -154,7 +162,13 @@
>> >         status = "disabled";
>> >  };
>> >
>> > +&usb_otg {
>> > +       dr_mode = "peripheral";
>> > +       status = "okay";
>> > +};
>> > +
>> >  &usbphy {
>> >         /* USB VBUS is always on */
>>
>> This comment does not match your commit message, which says it's always off.
>
> Oh I should say "USB Type-A port VBUS".

Yes you should probably update that comment, and also mention the OTG port's
VBUS is always off.

ChenYu

>>
>> ChenYu
>>
>> >         status = "okay";
>> > +       usb0_id_det-gpios = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
>> >  };
>> > --
>> > 2.11.1
>> >
>> > --
>> > You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
>> > To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
>> > For more options, visit https://groups.google.com/d/optout.
>>
>> --
>> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
