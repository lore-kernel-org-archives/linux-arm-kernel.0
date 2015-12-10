From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 10 Dec 2015 11:14:47 +0100
Subject: [PATCH 2/2] ARM: shmobile: r8a7793: Describe DMA for the serial
 ports
In-Reply-To: <20151210045444.GC6964@verge.net.au>
References: <1448589166-11612-1-git-send-email-horms+renesas@verge.net.au>
 <1448589166-11612-3-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdVfMp0awRZh6S7YiSPFpUyAvwGXSQb2RYU7DkK_SOwH9Q@mail.gmail.com>
 <20151210045444.GC6964@verge.net.au>
Message-ID: <CAMuHMdWCc-fZwr0eNBk5k4_qMuER76DDQndRiWX9zhrk0gqSQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2015 at 5:54 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Dec 09, 2015 at 11:47:36AM +0100, Geert Uytterhoeven wrote:
>> Hi Simon,
>>
>> On Fri, Nov 27, 2015 at 2:52 AM, Simon Horman
>> <horms+renesas@verge.net.au> wrote:
>> > Add DMA properties to all SCIF, SCIFA, SCIFB, and HSCIF device nodes.
>> >
>> > Based on similar work for the r8a7791 by Geert Uytterhoeven.
>> >
>> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>> > ---
>> >  arch/arm/boot/dts/r8a7793.dtsi | 36 ++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 36 insertions(+)
>> >
>> > diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
>> > index 3ac2ec0414a0..8d5cbdfc3d5d 100644
>> > --- a/arch/arm/boot/dts/r8a7793.dtsi
>> > +++ b/arch/arm/boot/dts/r8a7793.dtsi
>>
>> > @@ -394,6 +412,8 @@
>> >                 interrupts = <0 152 IRQ_TYPE_LEVEL_HIGH>;
>> >                 clocks = <&mstp7_clks R8A7793_CLK_SCIF0>;
>> >                 clock-names = "sci_ick";
>> > +               dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
>> > +               dma-names = "tx", "rx";
>> >                 power-domains = <&cpg_clocks>;
>> >                 status = "disabled";
>> >         };
>> > @@ -404,6 +424,8 @@
>> >                 interrupts = <0 153 IRQ_TYPE_LEVEL_HIGH>;
>> >                 clocks = <&mstp7_clks R8A7793_CLK_SCIF1>;
>> >                 clock-names = "sci_ick";
>> > +               dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
>>
>> This is duplicated from scif0, and should be:
>>
>>         dmas = <&dmac0 0x2d>, <&dmac0 0x2e>;
>>
>> > +               dma-names = "tx", "rx";
>>
>> After
>>
>>         sed -i -e 's/7791/779x/g' arch/arm/boot/dts/r8a7791.dtsi
>>         sed -i -e 's/7793/779x/g' arch/arm/boot/dts/r8a7793.dtsi
>>
>> arch/arm/boot/dts/r8a7791.dtsi and arch/arm/boot/dts/r8a7793.dtsi should
>> be identical ;-)
>
> Thanks, I have fixed that in v2.

Haven't seen that patch, but feel free to add my
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
after having corrected the scif1 DMA names.
The sooner it arrives in renesas-devel, the better (I have patches depending
on it).

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
