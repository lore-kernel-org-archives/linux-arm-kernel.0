From: horms@verge.net.au (Simon Horman)
Date: Fri, 10 Oct 2014 10:26:04 +0900
Subject: [PATCH 1/4] ARM: shmobile: r8a7790: Add RGX clock to device tree
In-Reply-To: <CAMuHMdV59fkhAxGrvx4VERWPm5v4roy1WNVyPAO73+W-bPn16A@mail.gmail.com>
References: <1412848985-29353-1-git-send-email-ykaneko0929@gmail.com>
 <1412848985-29353-2-git-send-email-ykaneko0929@gmail.com>
 <CAMuHMdV59fkhAxGrvx4VERWPm5v4roy1WNVyPAO73+W-bPn16A@mail.gmail.com>
Message-ID: <20141010012603.GH5856@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 09, 2014 at 02:27:07PM +0200, Geert Uytterhoeven wrote:
> Hi Kaneko-san, Abe-san,
> 
> On Thu, Oct 9, 2014 at 12:03 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> > From: Kouei Abe <kouei.abe.cp@renesas.com>
> 
> Thanks for your patches!
> 
> > Signed-off-by: Kouei Abe <kouei.abe.cp@renesas.com>
> > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> > ---
> >  arch/arm/boot/dts/r8a7790.dtsi            | 9 +++++----
> >  include/dt-bindings/clock/r8a7790-clock.h | 1 +
> >  2 files changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> > index 2380fd5..27c038c 100644
> > --- a/arch/arm/boot/dts/r8a7790.dtsi
> > +++ b/arch/arm/boot/dts/r8a7790.dtsi
> 
> >                         clock-output-names =
> > -                               "jpu", "tmu1", "tmu3", "tmu2", "cmt0", "tmu0", "vsp1-du1",
> > -                               "vsp1-du0", "vsp1-rt", "vsp1-sy";
> > +                               "jpu", "tmu1", "pvrsrvkm", "tmu3", "tmu2", "cmt0", "tmu0",
> > +                               "vsp1-du1", "vsp1-du0", "vsp1-rt", "vsp1-sy";
> 
> Why is this clock called "pvrsrvkm"?
> The datasheet calls this clock "3DG".

Good question.

I am of two minds on how to handle this:

1. Simply change the name to 3dg (simple)
2. Seek clarification from Abe-san and his team

Currently I am leaning to 1 as following the data-sheet feels like
the right thing to do.

Does anyone have an opinion on this?

> > --- a/include/dt-bindings/clock/r8a7790-clock.h
> > +++ b/include/dt-bindings/clock/r8a7790-clock.h
> 
> > +#define R8A7790_CLK_PVRSRVKM           12
> 
> Likewise.
> 
> My comments also apply to the corresponding patch for r8a7791.
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
