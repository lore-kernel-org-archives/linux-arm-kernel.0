From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sat, 17 Nov 2018 09:11:48 -0800
Subject: [PATCH v6 3/3] arm64: dts: allwinner: a64: enable sound on
 Pinebook
In-Reply-To: <CAGb2v65vDRTUDo894nXvOi8xEkMzeymbU=OQjdyY-Eh38T7F+A@mail.gmail.com>
References: <20181108063929.29720-1-anarsoul@gmail.com>
 <20181108063929.29720-4-anarsoul@gmail.com>
 <CAGb2v65zb4rXJJv018AfDC-YQgAAmahmQ=-Bb5CyU3kA6wBAqg@mail.gmail.com>
 <CA+E=qVegv61NgF4peK=Bz2RDvjCUX+M_njrpC4Ph+Jv+r2KFgg@mail.gmail.com>
 <CAGb2v65vDRTUDo894nXvOi8xEkMzeymbU=OQjdyY-Eh38T7F+A@mail.gmail.com>
Message-ID: <CA+E=qVfVEiE0Mvc_0HxWkkpXb9U5CJmtZtPxVPLrOZKD1JfkUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 17, 2018 at 8:02 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Thu, Nov 15, 2018 at 1:48 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> >
> > On Wed, Nov 7, 2018 at 11:30 PM Chen-Yu Tsai <wens@csie.org> wrote:
> > > > +
> > > > +       speaker_amp: speaker_amp {
> > > > +               compatible = "simple-audio-amplifier";
> > > > +               enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
> > >
> > > You might want to add a sound-name-prefix property. See
> > >
> > >     Documentation/devicetree/bindings/sound/name-prefix.txt
> > >
> > > Also this should have a reference to its power supply regulator.
> >
> > You're right, it should reference its power supply which should be a
> > fixed regulator controlled via GPIO from AXP803.
> >
> > Unfortunately there's no AXP803 GPIO support yet and
> > simple-audio-amplifier doesn't have regulator property.
> >
> > I have no time (and interest) to work on it in near future, so if
> > anyone wants to pick it up - feel free to do so.
>
> Understood. I can try to pick it up when I have some extra time.
>
> On the other hand, I tried this series on my Pine64 and (with
> the necessary device tree changes) on my Bananapi M64. While
> audio played (did not stall), no audio was actually coming out
> of the headphones I had plugged in. I made sure that all needed
> mixer controls were enabled, and the DAPM graph read all green
> from the DAI to the Headphone jack.
>
> Any ideas?

Please show output of amixer. My guess is that you don't have 'AIF1
DAC' enabled.

>
> Regards
> ChenYu
