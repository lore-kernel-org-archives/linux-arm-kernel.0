From: horms@verge.net.au (Simon Horman)
Date: Wed, 27 Aug 2014 17:09:47 +0900
Subject: [PATCH 1/3 repost] clocksource: sh_cmt: Document SoC specific
 bindings
In-Reply-To: <CAMuHMdUv6bwSjHLhHumiuaBFS8WAw0y1sNq4PcofjOz6UiOfrA@mail.gmail.com>
References: <1409117300-2133-1-git-send-email-horms+renesas@verge.net.au>
 <1409117300-2133-2-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdUv6bwSjHLhHumiuaBFS8WAw0y1sNq4PcofjOz6UiOfrA@mail.gmail.com>
Message-ID: <20140827080946.GD5936@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 08:55:36AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Wed, Aug 27, 2014 at 7:28 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > n general Renesas hardware is not documented to the extent
> > where the relationship between IP blocks on different SoCs can be assumed
> > although they may appear to operate the same way. Furthermore the
> > documentation typically does not specify a version for individual
> > IP blocks. For these reasons a convention of using the SoC name in place
> > of a version and providing SoC-specific compat strings has been adopted.
> >
> > Although not universally liked this convention is used in the bindings
> > for the drivers a number of drivers for Renesas hardware. The purpose
> 
> s/the drivers //

Thanks.

> 
> > of this patch is to update the Renesas R-Car Compare Match Timer (CMT)
> > driver to follow this convention.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> 
> 
> > ---
> > * I plan to follow up with patches to use these new bindings in the
> >   dtsi files for the affected SoCs.
> > ---
> >  .../devicetree/bindings/timer/renesas,cmt.txt      | 26 +++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.txt b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
> > index a17418b..500bad2 100644
> > --- a/Documentation/devicetree/bindings/timer/renesas,cmt.txt
> > +++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
> > @@ -16,10 +16,34 @@ Required Properties:
> >                 (CMT0 on sh7372, sh73a0 and r8a7740)
> >      - "renesas,cmt-32-fast" for the 32-bit CMT with fast clock support
> >                 (CMT[234] on sh7372, sh73a0 and r8a7740)
> > +    - "renesas,cmt-32-fast-r8a7740" for the R8A7740 32-bit CMT with fast
> > +               clock support (CMT[234])
> > +    - "renesas,cmt-32-fast-sh7372" for the SH7372 32-bit CMT with fast
> > +               clock support (CMT[234])
> > +    - "renesas,cmt-32-fast-sh73a0" for the SH73A0 32-bit CMT with fast
> > +               clock support (CMT[234])
> 
> > +    - "renesas,cmt-32-r8a7740" for the R8a7740 32-bit CMT
> > +               (CMT0)
> > +    - "renesas,cmt-32-sh7372" for the SH7372 32-bit CMT
> > +               (CMT0)
> > +    - "renesas,cmt-32-sh73a0" for the SH73a0 32-bit CMT
> > +               (CMT0)
> 
> I'd move these 3 non-fast "renesas,cmt-32-*" values up, under
> "renesas,cmt-32".
> 
> >      - "renesas,cmt-48" for the 48-bit CMT
> >                 (CMT1 on sh7372, sh73a0 and r8a7740)
> >      - "renesas,cmt-48-gen2" for the second generation 48-bit CMT
> >                 (CMT[01] on r8a73a4, r8a7790 and r8a7791)
> > +    - "renesas,cmt-48-r8a73a4" for the R8A73A4 48-bit CMT
> > +               (CMT[01])
> > +    - "renesas,cmt-48-r8a7740" for the R8A7740 48-bit CMT
> > +               (CMT1)
> > +    - "renesas,cmt-48-r8a7790" for the R8A7790 48-bit CMT
> > +               (CMT[01])
> > +    - "renesas,cmt-48-r8a7791" for the R8A7791 48-bit CMT
> > +               (CMT[01])
> > +    - "renesas,cmt-48-sh7372" for the SH7372 48-bit CMT
> > +               (CMT1)
> > +    - "renesas,cmt-48-sh73a0" for the SH73A0 48-bit CMT
> > +               (CMT1)
> 
> I'd split the above in original and gen2.

Sure. I'll re-order things as you suggest.

> Perhaps you can also add blank lines in between the 4 blocks of
> types; the list is getting long?

Good idea.

> Apart from the minor issues above
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> (for the whole series)
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
