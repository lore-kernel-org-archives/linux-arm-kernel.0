From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 29 Apr 2015 20:12:32 +0200
Subject: [PATCH] ARM: gic: Document Power and Clock Domain optional
 properties
In-Reply-To: <20150429151527.GA8781@leverpostej>
References: <1430146811-29862-1-git-send-email-geert+renesas@glider.be>
 <20150427155427.GB16191@leverpostej>
 <CAMuHMdVT=vzFazUsJtvPsyB8zX-WJqp19RNVYA=UMfWZtHnF=Q@mail.gmail.com>
 <20150427171502.GD16191@leverpostej>
 <CAMuHMdVY5Oh7b9Pme2jiwtV4GBPqK-T5nfxnB9_1ufFzueUjLA@mail.gmail.com>
 <20150429125703.GB11757@leverpostej>
 <CAMuHMdU1T9t8O8J4F0KkhcoeYO9sNLpp+jARaCEP0ZKiVgBqJA@mail.gmail.com>
 <20150429151527.GA8781@leverpostej>
Message-ID: <CAMuHMdVao2jOV7kZrcTw9UMa4kvSRMhfN5KQgQ8V-4fPS6ouaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 29, 2015 at 5:15 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
>> > index 7b315e3..02c8bb4 100644
>> > --- a/drivers/irqchip/irq-gic.c
>> > +++ b/drivers/irqchip/irq-gic.c
>> > @@ -959,6 +959,7 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>> >         irq_hw_number_t hwirq_base;
>> >         struct gic_chip_data *gic;
>> >         int gic_irqs, irq_base, i;
>> > +       unsigned long iidr;
>> >
>> >         BUG_ON(gic_nr >= MAX_GIC_NR);
>> >
>> > @@ -996,6 +997,9 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>> >                 gic_set_base_accessor(gic, gic_get_common_base);
>> >         }
>> >
>> > +       iidr = readl_relaxed(gic_data_dist_base(gic) + GIC_DIST_IIDR);
>> > +       pr_info("GICD_IIDR reports 0x%08lx\n", (unsigned long)iidr);
>>
>> No need for the cast.
>
> For arm64 there is ;)

Why? iidr is already unsigned long.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
