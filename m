From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 12 Oct 2015 09:30:38 +0200
Subject: [PATCH 3/5] ARM: shmobile: R-Mobile: add missing of_node_put
In-Reply-To: <20151012092910.7580c2b9@free-electrons.com>
References: <1444480254-14399-1-git-send-email-Julia.Lawall@lip6.fr>
 <1444480254-14399-4-git-send-email-Julia.Lawall@lip6.fr>
 <CAMuHMdUVraBT+s1e-m89KmjbZnEQjBaSz+c93rCOWPMnT5CVPA@mail.gmail.com>
 <20151012092910.7580c2b9@free-electrons.com>
Message-ID: <CAMuHMdWxZG0tyESgGe=Ze_nrH8oHq1vW3xUBBnc8eNSMUUCExQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2015 at 9:29 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> On Mon, 12 Oct 2015 09:18:52 +0200, Geert Uytterhoeven wrote:
>
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
> Then BUG_ON(!pd); ?

kzalloc() will scream anyway.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
