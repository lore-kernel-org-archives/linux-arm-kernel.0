From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 12 Oct 2015 09:26:29 +0200
Subject: [PATCH 3/5] ARM: shmobile: R-Mobile: add missing of_node_put
In-Reply-To: <alpine.DEB.2.10.1510120923130.2652@hadrien>
References: <1444480254-14399-1-git-send-email-Julia.Lawall@lip6.fr>
 <1444480254-14399-4-git-send-email-Julia.Lawall@lip6.fr>
 <CAMuHMdUVraBT+s1e-m89KmjbZnEQjBaSz+c93rCOWPMnT5CVPA@mail.gmail.com>
 <alpine.DEB.2.10.1510120923130.2652@hadrien>
Message-ID: <CAMuHMdW0Bs3FVHk8T8kTPYxA4SwEb3PNMn7dZ2BiTD5crs5PrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julia,

On Mon, Oct 12, 2015 at 9:24 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> On Mon, 12 Oct 2015, Geert Uytterhoeven wrote:
>> On Sat, Oct 10, 2015 at 2:30 PM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
>> > --- a/arch/arm/mach-shmobile/pm-rmobile.c
>> > +++ b/arch/arm/mach-shmobile/pm-rmobile.c
>> > @@ -313,8 +313,10 @@ static int __init rmobile_add_pm_domains(void __iomem *base,
>> >                 }
>> >
>> >                 pd = kzalloc(sizeof(*pd), GFP_KERNEL);
>> > -               if (!pd)
>> > +               if (!pd) {
>> > +                       of_node_put(np);
>> >                         return -ENOMEM;
>> > +               }
>>
>> While technically this patch is correct, the system will be dead anyway if it
>> ever goes OOM at core_initcall() time.
>
> Maybe it would be better for the code to be correct to serve as an example
> (or to avoid serving as a bad example) for others?

Sure, as it's only a single call, that's fine for me.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
