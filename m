From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 21 Nov 2014 08:46:42 +0100
Subject: [PATCH/RFC] ARM: shmobile: dts: Add common file for MSIOF1
In-Reply-To: <CANqRtoR2d=tAU=hPQNgnNz4A1k4NzRD0g4qyv3kH7gWJ6jvCiw@mail.gmail.com>
References: <1416544027-5680-1-git-send-email-horms+renesas@verge.net.au>
 <CANqRtoRxd64yoXQaPbR-euRtT6MX9AnasF32sK6B_EKoE30fJA@mail.gmail.com>
 <20141121045920.GB9888@verge.net.au>
 <CANqRtoR2d=tAU=hPQNgnNz4A1k4NzRD0g4qyv3kH7gWJ6jvCiw@mail.gmail.com>
Message-ID: <CAMuHMdVcYw4TvHf+eKUQcMm55Ya4Lwm7_qyEUPkwiUA8xboXGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 6:14 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Fri, Nov 21, 2014 at 1:59 PM, Simon Horman <horms@verge.net.au> wrote:
>> On Fri, Nov 21, 2014 at 01:45:32PM +0900, Magnus Damm wrote:
>>> On Fri, Nov 21, 2014 at 1:27 PM, Simon Horman
>>> <horms+renesas@verge.net.au> wrote:
>>> > From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>>> >
>>> > The R-Car Gen 2 SoCs have MSIOF1 interfaces however they
>>> > are not exposed on any boards currently supported in mainline.
>>>
>>> Ok, but that's the same as many other devices on R-Car Gen2 SoCs no?
>>> Basically the SoC contains a hardware block but it is not used on the
>>> actual board. I wonder what made MSIOF1 a target for sudden code
>>> consolidation?
>>>
>>> > The purpose of r8a77xx-msiof1.dtsi is to be included
>>> > in a dts file if MSIOF1 is exposed by some means.
>>>
>>> Judging by the file name this seems to be a board specific property
>>> made generic somehow.
>>
>> Yes, it is board stuff not SoC stuff.
>>
>>> > Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>>> > [horms: Reworked into a separate dtsi file]
>>> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>>>
>>> [snip]
>>>
>>> > +&pfc {
>>> > +       msiof1_pins: spi2 {
>>> > +               renesas,groups = "msiof1_clk_c", "msiof1_sync_c", "msiof1_rx_c",
>>> > +                                "msiof1_tx_c";
>>> > +               renesas,function = "msiof1";
>>> > +       };
>>> > +};
>>> > +
>>> > +&msiof1 {
>>> > +       pinctrl-0 = <&msiof1_pins>;
>>> > +       pinctrl-names = "default";
>>> > +
>>> > +       status = "okay";
>>> > +};
>>>
>>> The DTS above only works on boards that are using the "C" set of pins
>>> for the MSIOF1. Other configurations will not work. It also assumes
>>> that all SoC code is using the same strings for the PFC which may or
>>> may not be true.
>>>
>>> Does some common policy for the Linux kernel exist about how to break
>>> out board specific device support in DTS? If so we should follow it.
>>>
>>> If not, from my conservative view point this patch looks like over
>>> doing code sharing with increased overhead and no apparent upside
>>> except more complex dependencies.
>>
>> Perhaps it would be best just to drop it.
>>
>> The patch that this code was based on illustrates how to enable
>> MSIOF1 on the koelsch. People can find that and use it if they
>> wish to use MSIOF1.
>
> Thanks, that sounds like a good plan to me.

If it's just meant to serve as an example...

There is already an example in e.g. r8a7791-koelsch.dts, for MSIOF0.
Given the implementer may have to change the "C" set of pins to the set of
pins he wants to use, I think it's a minor hassle to also have to change the
MSIOF instance number. And he may want to use MSIOF2 or 3, too.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
