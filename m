From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 22 Jan 2016 08:46:37 +0100
Subject: [PATCH 1/2] ARM: dts: r8a7793: add CAN clocks
In-Reply-To: <20160122004823.GA15068@verge.net.au>
References: <1453352981-16104-1-git-send-email-horms+renesas@verge.net.au>
 <1453352981-16104-2-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdX5sZ7yNjgu8Ns26+91+ui2YuVfGavJi_XRa6Kd-yzoBQ@mail.gmail.com>
 <20160121121525.GA6833@verge.net.au>
 <20160122004823.GA15068@verge.net.au>
Message-ID: <CAMuHMdXDrFFhsTQ_2arc4rq-NiX-pg_a60YbJZE352Tg856-yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 22, 2016 at 1:48 AM, Simon Horman <horms@verge.net.au> wrote:
>> > > --- a/arch/arm/boot/dts/r8a7793.dtsi
>> > > +++ b/arch/arm/boot/dts/r8a7793.dtsi
>> > > @@ -706,12 +706,30 @@
>> > >                         clock-output-names = "extal";
>> > >                 };
>> > >
>> > > +               /* External USB clock - can be overridden by the board */
>> > > +               usb_extal_clk: usb_extal_clk {
>> > > +                       compatible = "fixed-clock";
>> > > +                       #clock-cells = <0>;
>> > > +                       clock-frequency = <48000000>;
>> > > +                       clock-output-names = "usb_extal";
>> > > +               };
>> > > +
>> > > +               /* External CAN clock */
>> > > +               can_clk: can_clk {
>> > > +                       compatible = "fixed-clock";
>> > > +                       #clock-cells = <0>;
>> > > +                       /* This value must be overridden by the board. */
>> > > +                       clock-frequency = <0>;
>> > > +                       clock-output-names = "can_clk";
>> > > +                       status = "disabled";
>> > > +               };
>> > > +
>> > >                 /* Special CPG clocks */
>> > >                 cpg_clocks: cpg_clocks at e6150000 {
>> > >                         compatible = "renesas,r8a7793-cpg-clocks",
>> > >                                      "renesas,rcar-gen2-cpg-clocks";
>> > >                         reg = <0 0xe6150000 0 0x1000>;
>> > > -                       clocks = <&extal_clk>;
>> > > +                       clocks = <&extal_clk &usb_extal_clk>;
>> > >                         #clock-cells = <1>;
>> > >                         clock-output-names = "main", "pll0", "pll1", "pll3",
>> > >                                              "lb", "qspi", "sdh", "sd0", "z",
>> >
>> > To create the "rcan" clock, it should be listed in clock-output-names.
>
> Checking this morning I see that it is already there.
> The next line of the file is:
>
>                                              "rcan", "adsp";

I stand corrected.

BTW, that means you saw "failed to register ... rcan" messages
before?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
