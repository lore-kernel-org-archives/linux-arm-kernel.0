From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 15 Mar 2016 08:28:42 +0100
Subject: [PATCH 1/2] ARM: dts: r8a7794: add CAN clocks to device tree
In-Reply-To: <20160314235659.GA23279@verge.net.au>
References: <1457922543-20975-1-git-send-email-horms+renesas@verge.net.au>
 <1457922543-20975-2-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdUWN9UVsDFxRCH6b+i7ERP5-W5wc6oU+OjYi=VYXS6UCQ@mail.gmail.com>
 <20160314235659.GA23279@verge.net.au>
Message-ID: <CAMuHMdVEoj5-ar0bNPB5XH7RtoR-v5bNDuZ87SwNzqvC670E2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Tue, Mar 15, 2016 at 12:56 AM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Mar 14, 2016 at 10:23:01AM +0100, Geert Uytterhoeven wrote:
>> On Mon, Mar 14, 2016 at 3:29 AM, Simon Horman
>> <horms+renesas@verge.net.au> wrote:
>> > --- a/arch/arm/boot/dts/r8a7794.dtsi
>> > +++ b/arch/arm/boot/dts/r8a7794.dtsi
>> > @@ -844,6 +844,24 @@
>> >                         clock-output-names = "extal";
>> >                 };
>> >
>> > +               /* External USB clock - can be overridden by the board */
>> > +               usb_extal_clk: usb_extal_clk {
>> > +                       compatible = "fixed-clock";
>> > +                       #clock-cells = <0>;
>> > +                       clock-frequency = <48000000>;
>> > +                       clock-output-names = "usb_extal";
>>
>> "clock-output-names" is optional these days, so please drop it.
>
> Thanks, I will drop it from this patch.
>
> Do we have a plan to remove it from existing nodes?
> Should I do a sweep of the Renesas DTS files?

That's up to you.

It's more churn, but from the other side, it avoids people copying deprecated
practices.

> And in particular, should it be removed from cpg_clocks ?

It's not optional for clocks with multiple outputs, cfr. the issues we had with
cpg_clocks on H3, before the advent of the CPG/MSSR driver.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
