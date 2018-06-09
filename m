From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sat, 9 Jun 2018 14:10:06 +0200
Subject: [PATCH v4 2/3] arm: shmobile: Add the R9A06G032 SMP enabler driver
In-Reply-To: <CAL_JsqK6Pb5ZbqAATpQNK-C=iVNA655H__5RERMmPTUOrX3Few@mail.gmail.com>
References: <1528198148-23308-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528198148-23308-3-git-send-email-michel.pollet@bp.renesas.com>
 <0481173f-6384-98d6-707c-89dc5ef103f0@gmail.com>
 <OSBPR01MB2054E3A1E383495F3534B551D2650@OSBPR01MB2054.jpnprd01.prod.outlook.com>
 <9cef7124-3020-5741-f3a2-6925a6c8f0f3@gmail.com>
 <79c0899e-7df1-1fe7-9681-ad3bd51feda7@gmail.com>
 <OSBPR01MB205442B483C792125E6A6AF7D2640@OSBPR01MB2054.jpnprd01.prod.outlook.com>
 <CAL_JsqLn+x0JCkjwABU7XkPsgvyVdiCRq=gZTfUBbbR4-c+1bQ@mail.gmail.com>
 <OSBPR01MB2054A701CF65784FAB947692D27B0@OSBPR01MB2054.jpnprd01.prod.outlook.com>
 <CAMuHMdUOqLhmb8kXOxriQ5mt_4rDQJbUqGsQiJBSkq5J5FWG7w@mail.gmail.com>
 <CAL_JsqK6Pb5ZbqAATpQNK-C=iVNA655H__5RERMmPTUOrX3Few@mail.gmail.com>
Message-ID: <CAMuHMdX2gsTJttum6_KPLcM7LTpSj3weHB7OwvBmuc4AjdfpuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Fri, Jun 8, 2018 at 10:41 PM Rob Herring <robh+dt@kernel.org> wrote:
> On Fri, Jun 8, 2018 at 2:47 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Jun 8, 2018 at 8:50 AM, Michel Pollet
> > <michel.pollet@bp.renesas.com> wrote:
> >>> > + I add this to the cpu.txt, as a separate patch:
> >>> > # On other systems, the property can be either
> >>> >   32 bits or 64 bits, it is the driver's responsibility
> >>> >   to deal with either sizes.
> >>>
> >>> That is definitely not what we want to say. Use of 32-bit should be
> >>> considered out of spec. Yes, we have a few platforms in that category, but
> >>> they already handle that themselves. Would be nice to fix them, but at least
> >>> the STi platforms don't seem too active.
> >>>
> >>> IMO, we should delete whatever text we can here and at most just refer to
> >>> the spec.
> >>
> >> So actually I didn't use 32 bits by plain chance, I read the cpu.txt file which says
> >> that 64 bits systems use 64 bits property, concluded that in my case I ought to
> >> use 32 bits, then grepped around and found other systems using 32 bits, therefore
> >> I went forward and used it..
> >>
> >> Nothing said here that it should be 64 bits everywhere -- So the documentation
> >> needs fixing somehow. Right now it certainly led me wrong.
> >
> > Perhaps we should add to Documentation/devicetree/bindings/ the standard
> > bindings from ePAPR and successors, too?
>
> I hope you mean *reference* here, not duplicate the bindings here. We
> want to move in the other direction and move the common bindings out
> of the kernel and into the spec.

I did mean copy... I usually grep in Documentation/devicetree/bindings/,
and fall back to the spec only rarely, mostly because the spec usually
doesn't cover what I need.

I am aware of the ongoing work on updating the spec. I guess it's a
chicken-and-egg problem...

A list of standardized properties under Documentation/devicetree/bindings/,
referring to the spec may be a good interim solution. So at least it would show
it with git grep.

> The real solution here is validation which I'm working on. I had
> already converted cpus.txt. Here's an example of the results of the
> validation:
>
> arch/arm/boot/dts/stih410-b2120.dt.yaml:1962:7: cpu at 0: 'enable-method'
> is a dependency of 'cpu-release-addr'
> arch/arm/boot/dts/stih410-b2120.dt.yaml:1965:26:
> cpu at 0:cpu-release-addr: [155254948] is too short

Thanks, nice!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
