From: horms@verge.net.au (Simon Horman)
Date: Tue, 21 Oct 2014 17:02:56 +0100
Subject: [PATCH 1/4] ARM: shmobile: r8a7790: Add RGX clock to device tree
In-Reply-To: <CANqRtoTc2P0jL+LVgwRhp-c0nTYMUHr=Y_9L-DhFduFr6Ti0Xg@mail.gmail.com>
References: <1412848985-29353-1-git-send-email-ykaneko0929@gmail.com>
 <1412848985-29353-2-git-send-email-ykaneko0929@gmail.com>
 <CAMuHMdV59fkhAxGrvx4VERWPm5v4roy1WNVyPAO73+W-bPn16A@mail.gmail.com>
 <20141010012603.GH5856@verge.net.au>
 <CANqRtoTc2P0jL+LVgwRhp-c0nTYMUHr=Y_9L-DhFduFr6Ti0Xg@mail.gmail.com>
Message-ID: <20141021160255.GC4809@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 20, 2014 at 02:53:37AM +0200, Magnus Damm wrote:
> Hi Simon,
> 
> On Fri, Oct 10, 2014 at 3:26 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Oct 09, 2014 at 02:27:07PM +0200, Geert Uytterhoeven wrote:
> >> Hi Kaneko-san, Abe-san,
> >>
> >> On Thu, Oct 9, 2014 at 12:03 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> >> > From: Kouei Abe <kouei.abe.cp@renesas.com>
> >>
> >> Thanks for your patches!
> >>
> >> > Signed-off-by: Kouei Abe <kouei.abe.cp@renesas.com>
> >> > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> >> > ---
> >> >  arch/arm/boot/dts/r8a7790.dtsi            | 9 +++++----
> >> >  include/dt-bindings/clock/r8a7790-clock.h | 1 +
> >> >  2 files changed, 6 insertions(+), 4 deletions(-)
> >> >
> >> > diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> >> > index 2380fd5..27c038c 100644
> >> > --- a/arch/arm/boot/dts/r8a7790.dtsi
> >> > +++ b/arch/arm/boot/dts/r8a7790.dtsi
> >>
> >> >                         clock-output-names =
> >> > -                               "jpu", "tmu1", "tmu3", "tmu2", "cmt0", "tmu0", "vsp1-du1",
> >> > -                               "vsp1-du0", "vsp1-rt", "vsp1-sy";
> >> > +                               "jpu", "tmu1", "pvrsrvkm", "tmu3", "tmu2", "cmt0", "tmu0",
> >> > +                               "vsp1-du1", "vsp1-du0", "vsp1-rt", "vsp1-sy";
> >>
> >> Why is this clock called "pvrsrvkm"?
> >> The datasheet calls this clock "3DG".
> >
> > Good question.
> >
> > I am of two minds on how to handle this:
> >
> > 1. Simply change the name to 3dg (simple)
> > 2. Seek clarification from Abe-san and his team
> >
> > Currently I am leaning to 1 as following the data-sheet feels like
> > the right thing to do.
> >
> > Does anyone have an opinion on this?
> 
> We are following the data sheet names everywhere else so I don't see
> why this should be any exception. So my opinion is aligned with yours
> - simply go with 1. above.

Thanks. Kaneko-san has done so. And I have queued up the patches.
