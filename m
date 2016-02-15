From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 15 Feb 2016 08:45:48 +0100
Subject: [PATCH 01/68] ARM: dts: gose: Add GPIO keys to DT
In-Reply-To: <20160215071817.GA4528@verge.net.au>
References: <cover.1455303422.git.horms+renesas@verge.net.au>
 <d7d5974b156e2ef7436483de00ccada5987c9d31.1455303422.git.horms+renesas@verge.net.au>
 <CAMuHMdVefum3YbaxhMX_0hHrmTFYU-pWYZTwSUveQDLFArLdYw@mail.gmail.com>
 <20160215071817.GA4528@verge.net.au>
Message-ID: <CAMuHMdVjJmKuTNJndhss5yBJ5AGt3crMZe5gTXbwC32B-Aw1PA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 8:18 AM, Simon Horman <horms@verge.net.au> wrote:
> On Sat, Feb 13, 2016 at 09:23:47PM +0100, Geert Uytterhoeven wrote:
>> On Fri, Feb 12, 2016 at 8:04 PM, Simon Horman
>> <horms+renesas@verge.net.au> wrote:
>> > Instantiate the GPIO keys in the gose device tree.
>> >
>> > Based on similar work for the koelsch board by Laurent Pinchart.
>> >
>> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>> > Tested-by: Magnus Damm <damm+renesas@opensource.se>
>> > ---
>> >  arch/arm/boot/dts/r8a7793-gose.dts | 82 ++++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 82 insertions(+)
>> >
>> > diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
>> > index baa59fe84298..ccbc1c66cc6c 100644
>> > --- a/arch/arm/boot/dts/r8a7793-gose.dts
>> > +++ b/arch/arm/boot/dts/r8a7793-gose.dts
>> > @@ -31,6 +31,88 @@
>> >                 device_type = "memory";
>> >                 reg = <0 0x40000000 0 0x40000000>;
>> >         };
>> > +
>> > +       gpio-keys {
>> > +               compatible = "gpio-keys";
>> > +
>> > +               key-1 {
>> > +                       gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
>> > +                       linux,code = <KEY_1>;
>> > +                       label = "SW2-1";
>> > +                       gpio-key,wakeup;
>>
>> In the mean time, "gpio-key,wakeup" has been deprecated in favor of
>> "wakeup-source".
>
> Is the change just a matter of s/gpio-key,wakeup/wakeup-source/ ?
> If so I'll sort things out.

Yes, cfr. e.g. commit 0cc16889e77a95568806b1e45af104f75547eac9
("ARM: dts: shmobile/r8a7xxx: replace gpio-key, wakeup with
wakeup-source property")

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
