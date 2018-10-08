From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 8 Oct 2018 17:12:56 +0200
Subject: [PATCH 29/36] dt-bindings: arm: Convert Renesas board/soc
 bindings to json-schema
In-Reply-To: <CAL_JsqLbh-UhYTWN_nMDVwGSh0amh6OsOK8H-+xiTdVynL3XiA@mail.gmail.com>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-30-robh@kernel.org>
 <CAMuHMdU=rBV4b3EcenvtMPevx14pvTDcnQ7VDg02VZFiFuU-uw@mail.gmail.com>
 <CAL_JsqLbh-UhYTWN_nMDVwGSh0amh6OsOK8H-+xiTdVynL3XiA@mail.gmail.com>
Message-ID: <CAMuHMdVtuKkytpHxJfWHw=-R09_AMZ8Tn=ixjPSSRydQL6qK2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Mon, Oct 8, 2018 at 4:57 PM Rob Herring <robh@kernel.org> wrote:
> On Mon, Oct 8, 2018 at 2:47 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Oct 5, 2018 at 6:59 PM Rob Herring <robh@kernel.org> wrote:
> > > Convert Renesas SoC bindings to DT schema format using json-schema.

> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/arm/shmobile.yaml
> > > @@ -0,0 +1,205 @@

> > > +      - description: Kingfisher (SBEV-RCAR-KF-M03)
> > > +        items:
> > > +          - const: shimafuji,kingfisher
> > > +          - enum:
> > > +              - renesas,h3ulcb
> > > +              - renesas,m3ulcb
> > > +          - enum:
> > > +              - renesas,r8a7795
> > > +              - renesas,r8a7796
> >
> > This looks a bit funny: all other entries have the "const" last, and
> > use it for the
> > SoC number. May be correct, though.
> > To clarify, this is an extension board that can fit both the [HM]3ULCB
> > boards (actually also the new M3NULCB, I think).
>
> This being Kingfisher?

Correct.

> I wrote this based on dts files in the tree. There's 2 combinations that I see:
>
> "shimafuji,kingfisher", "renesas,h3ulcb", "renesas,r8a7795"
> "shimafuji,kingfisher", "renesas,m3ulcb", "renesas,r8a7796"
>
> The schema allows 4 combinations (1 * 2 * 2). I have no idea if the
> other combinations are possible. If not, then we could rewrite this as
> 2 entries with 3 const values each.

I expect there will soon be a third one:

    "shimafuji,kingfisher", "renesas,m3nulcb", "renesas,r8a77965"

Technically, {h3,m3,m3n}ulcb are the same board (although there may be
minor revision differences), with a different SiP mounted.
But they are called/marketed depending on which SiP is mounted.

And on top of that, you can plug in a Kingfisher daughterboard. Could be an
overlay ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
