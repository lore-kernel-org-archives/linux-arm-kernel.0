From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 18 Oct 2017 09:42:05 +0800
Subject: [linux-sunxi] [PATCH 08/10] ARM: dts: sun4i: Enable HDMI support
 on some A10 devices
In-Reply-To: <20171017181005.7x6wwuidzsm7kep3@flea.lan>
References: <20171017121807.2994-1-wens@csie.org>
 <20171017121807.2994-9-wens@csie.org>
 <CAGb2v65Z2N24AZp=Y-_YgKuZiT1uSDX5pzMrceU3+TY=+Zdf7g@mail.gmail.com>
 <20171017181005.7x6wwuidzsm7kep3@flea.lan>
Message-ID: <CAGb2v67tqq7WF7X=xbVOc0_YqBnRTWLF-UyDDmFyRjdYUgbC2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 18, 2017 at 2:10 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Oct 17, 2017 at 10:38:45PM +0800, Chen-Yu Tsai wrote:
>> > diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
>> > index 2d1b4329f54a..e39ec9beef75 100644
>> > --- a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
>> > +++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
>> > @@ -58,6 +58,17 @@
>> >                 stdout-path = "serial0:115200n8";
>> >         };
>> >
>> > +       hdmi-connector {
>> > +               compatible = "hdmi-connector";
>> > +               type = "a";
>> > +
>> > +               port {
>> > +                       hdmi_con_in: endpoint {
>> > +                               remote-endpoint = <&hdmi_out_con>;
>> > +                       };
>> > +               };
>> > +       };
>> > +
>> >         leds {
>> >                 compatible = "gpio-leds";
>> >                 pinctrl-names = "default";
>> > @@ -106,6 +117,16 @@
>> >         status = "okay";
>> >  };
>>
>> The LIME's dts change is missing the &de part. :(
>> I can fix this when applying.
>
> I've applied all of rest, I'll leave that one up to you, with my
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Done.
