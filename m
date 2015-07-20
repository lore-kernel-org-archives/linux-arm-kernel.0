From: djkurtz@chromium.org (Daniel Kurtz)
Date: Mon, 20 Jul 2015 22:59:38 +0800
Subject: [PATCH v2 5/5] arm64: dts: mediatek: add xHCI & usb phy for mt8173
In-Reply-To: <1437403873.15139.5.camel@mtksdaap41>
References: <1436348468-4126-1-git-send-email-chunfeng.yun@mediatek.com>
 <1436348468-4126-6-git-send-email-chunfeng.yun@mediatek.com>
 <CAGS+omDfUv0KW8K45rLoN8qUV2Q_vgWFK_X4Ojb6K55G9tiehA@mail.gmail.com>
 <1437403179.11518.10.camel@mhfsdcap03> <1437403873.15139.5.camel@mtksdaap41>
Message-ID: <CAGS+omBokK5MXSGny0LpH8KBZup-d7XB_0WF=5JEg1BGbsJpMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 20, 2015 at 10:51 PM, Yingjoe Chen
<yingjoe.chen@mediatek.com> wrote:
>
> Hi Daniel, Chunfeng,
>
>
> On Mon, 2015-07-20 at 22:39 +0800, chunfeng yun wrote:
>> Hi,
>>
>> On Tue, 2015-07-14 at 18:12 +0800, Daniel Kurtz wrote:
> <...>
>> > > +
>> > > +       usb_p1_vbus: fixedregulator at 0 {
>> >
>> > Why @0 ?
>> It is the first fixed regulator, so set it to 0 as a index.
>> I will remove it later
>
> Since this name should be unique, I think we should use gpio number as
> address for fixedregulator in case we need other fixedregulators. So
> this could be:
>
>         usb_p1_vbus: fixedregulator at 130 {
>
> Also, we should sort according to the address(gpio number) for these
> nodes. Does this make sense?

Yes - that makes some sense.
But, a quick check of other "fixedregulator@" nodes in
arch/arm/boot/dts/ shows that mostly they use @0 , @1.
So, I think the original patch is probably fine.

Sorry for the noise,
-Dan

>
> Joe.C
>
>> >
>> > > +               compatible = "regulator-fixed";
>> > > +               regulator-name = "usb_vbus";
>> > > +               regulator-min-microvolt = <5000000>;
>> > > +               regulator-max-microvolt = <5000000>;
>> > > +               gpio = <&pio 130 GPIO_ACTIVE_HIGH>;
>> > > +               enable-active-high;
>> > > +       };
>
>
