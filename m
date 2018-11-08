From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed, 7 Nov 2018 23:27:23 -0800
Subject: [PATCH v6 2/3] arm64: dts: allwinner: a64: enable sound on Pine64
 and SoPine
In-Reply-To: <CAGb2v64GUsd2gsZ8B-4AJodJN5_rfafGAiaOng5HsphkGJYxGA@mail.gmail.com>
References: <20181108063929.29720-1-anarsoul@gmail.com>
 <20181108063929.29720-3-anarsoul@gmail.com>
 <CAGb2v64GUsd2gsZ8B-4AJodJN5_rfafGAiaOng5HsphkGJYxGA@mail.gmail.com>
Message-ID: <CA+E=qVdwgYoNTncVDV7T1Eh=nRZG_8Q5uHSU4ZmDgUuG7+qP_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 7, 2018 at 11:11 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Thu, Nov 8, 2018 at 2:42 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> >
> > This commit enables I2S, digital and analog parts of audiocodec on
> > Pine64 and SoPine boards.
> >
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> >  .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 28 +++++++++++++++++++
> >  .../allwinner/sun50i-a64-sopine-baseboard.dts | 28 +++++++++++++++++++
> >  2 files changed, 56 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> > index c077b6c1f458..ff352bdfbb93 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> > @@ -75,6 +75,18 @@
> >         };
> >  };
> >
> > +&codec {
> > +       status = "okay";
> > +};
> > +
> > +&codec_analog {
> > +       status = "okay";
> > +};
> > +
> > +&dai {
> > +       status = "okay";
> > +};
> > +
> >  &de {
> >         status = "okay";
> >  };
> > @@ -264,6 +276,22 @@
> >         status = "disabled";
> >  };
> >
> > +&sound {
> > +       status = "okay";
> > +       simple-audio-card,widgets = "Microphone", "Microphone Jack",
> > +                                   "Headphone", "Headphone Jack";
> > +       simple-audio-card,routing =
> > +                       "Left DAC", "AIF1 Slot 0 Left",
> > +                       "Right DAC", "AIF1 Slot 0 Right",
> > +                       "Headphone Jack", "HP",
> > +                       "AIF1 Slot 0 Left ADC", "Left ADC",
> > +                       "AIF1 Slot 0 Right ADC", "Right ADC",
> > +                       "Left ADC", "ADC",
> > +                       "Right ADC", "ADC",
>
> As mentioned the above two don't belong in the device tree.
>
> > +                       "Microphone Jack", "HBIAS",
>
> Schematics says this is NC or not connected by default.
> You may want to ask Pine64 about this?
>
> Same comments for SoPine.

I'll just drop it. Not connected on schematics - we don't put it in dts.

>
> > +                       "MIC2", "Microphone Jack";
> > +};
> > +
> >  /* On Exp and Euler connectors */
> >  &uart0 {
> >         pinctrl-names = "default";
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> > index 53fcc9098df3..25d732df37c4 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> > @@ -80,6 +80,18 @@
> >         };
> >  };
> >
> > +&codec {
> > +       status = "okay";
> > +};
> > +
> > +&codec_analog {
> > +       status = "okay";
> > +};
> > +
> > +&dai {
> > +       status = "okay";
> > +};
> > +
> >  &de {
> >         status = "okay";
> >  };
> > @@ -164,6 +176,22 @@
> >         vcc-hdmi-supply = <&reg_dldo1>;
> >  };
> >
> > +&sound {
> > +       status = "okay";
> > +       simple-audio-card,widgets = "Microphone", "Microphone Jack",
> > +                                   "Headphone", "Headphone Jack";
> > +       simple-audio-card,routing =
> > +                       "Left DAC", "AIF1 Slot 0 Left",
> > +                       "Right DAC", "AIF1 Slot 0 Right",
> > +                       "Headphone Jack", "HP",
> > +                       "AIF1 Slot 0 Left ADC", "Left ADC",
> > +                       "AIF1 Slot 0 Right ADC", "Right ADC",
> > +                       "Left ADC", "ADC",
> > +                       "Right ADC", "ADC",
> > +                       "Microphone Jack", "HBIAS",
> > +                       "MIC2", "Microphone Jack";
> > +};
> > +
> >  &uart0 {
> >         pinctrl-names = "default";
> >         pinctrl-0 = <&uart0_pb_pins>;
> > --
> > 2.19.1
> >
