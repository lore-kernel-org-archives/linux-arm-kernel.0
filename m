From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 3 Nov 2015 15:43:27 +0100
Subject: [PATCH v11 1/8] arm64: renesas: r8a7795: Add Renesas R8A7795 SoC
 support
In-Reply-To: <20151103142810.GC4049@leverpostej>
References: <1444890243-6978-1-git-send-email-horms+renesas@verge.net.au>
 <1444890243-6978-2-git-send-email-horms+renesas@verge.net.au>
 <20151015105820.GF8825@leverpostej>
 <CAMuHMdU00wJcrb7EsFjkKMw-gy04tXdGoyzPRNL-cjYZH8zneA@mail.gmail.com>
 <20151103142810.GC4049@leverpostej>
Message-ID: <CAMuHMdUEJrOmCbBzGfLMHmBJjfac3V+f_AJ6K1ioqunabzoO=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, Nov 3, 2015 at 3:28 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Oct 21, 2015 at 03:34:39PM +0200, Geert Uytterhoeven wrote:
>> On Thu, Oct 15, 2015 at 12:58 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> >> > +           gic: interrupt-controller at 0xf1010000 {
>> >> +                     compatible = "arm,gic-400";
>> >> +                     #interrupt-cells = <3>;
>> >> +                     #address-cells = <0>;
>> >> +                     interrupt-controller;
>> >> +                     reg = <0x0 0xf1010000 0 0x1000>,
>> >> +                           <0x0 0xf1020000 0 0x2000>;
>> >> +                     interrupts = <GIC_PPI 9
>> >> +                                     (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
>> >> +             };
>> >
>> > No GICH and GICV?
>>
>> These seem to be defined in the "arm,gic-v3" DT bindings only, while this is
>> an "arm,gic-400" (GICD_IIDR 0x0200043b)?
>
> See the "GIC virtualization extensions (VGIC)" section in
> Documentation/devicetree/bindings/arm/gic.txt
>
>> I did notice hi6220.dtsi does have GICH and GICV, while it also claims
>> to be an "arm,gic-400"...
>
> That's fine, that's valid for any GICv2 with virtualization extensions.

All I can find in the docs are the two register blocks we have in the dtsi.

>> > Which exception level do CPUs boot at?
>>
>> No idea.
>
> For reference, the kernel should print it out just after booting all CPUs. e.g.
> on Juno:
>
> SMP: Total of 6 processors activated.
> CPU: All CPU(s) started at EL2

Thanks!

CPU: All CPU(s) started at EL1

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
