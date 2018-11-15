From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed, 14 Nov 2018 21:47:36 -0800
Subject: [PATCH v6 3/3] arm64: dts: allwinner: a64: enable sound on
 Pinebook
In-Reply-To: <CAGb2v65zb4rXJJv018AfDC-YQgAAmahmQ=-Bb5CyU3kA6wBAqg@mail.gmail.com>
References: <20181108063929.29720-1-anarsoul@gmail.com>
 <20181108063929.29720-4-anarsoul@gmail.com>
 <CAGb2v65zb4rXJJv018AfDC-YQgAAmahmQ=-Bb5CyU3kA6wBAqg@mail.gmail.com>
Message-ID: <CA+E=qVegv61NgF4peK=Bz2RDvjCUX+M_njrpC4Ph+Jv+r2KFgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 7, 2018 at 11:30 PM Chen-Yu Tsai <wens@csie.org> wrote:
> > +
> > +       speaker_amp: speaker_amp {
> > +               compatible = "simple-audio-amplifier";
> > +               enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
>
> You might want to add a sound-name-prefix property. See
>
>     Documentation/devicetree/bindings/sound/name-prefix.txt
>
> Also this should have a reference to its power supply regulator.

You're right, it should reference its power supply which should be a
fixed regulator controlled via GPIO from AXP803.

Unfortunately there's no AXP803 GPIO support yet and
simple-audio-amplifier doesn't have regulator property.

I have no time (and interest) to work on it in near future, so if
anyone wants to pick it up - feel free to do so.

Regards,
Vasily
