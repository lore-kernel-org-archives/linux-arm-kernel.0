From: horms@verge.net.au (Simon Horman)
Date: Wed, 30 Apr 2014 08:51:11 +0900
Subject: [PATCH 4/4] ARM: shmobile: marzen: Use disabled variant of clock
 workaround for scif devices
In-Reply-To: <CANqRtoS2p9+2tBWeOQ1K-JME7OrXJDW_afxgbW7YuqSi-WOEVg@mail.gmail.com>
References: <1398757406-30920-1-git-send-email-horms+renesas@verge.net.au>
 <1398757406-30920-5-git-send-email-horms+renesas@verge.net.au>
 <CANqRtoS2p9+2tBWeOQ1K-JME7OrXJDW_afxgbW7YuqSi-WOEVg@mail.gmail.com>
Message-ID: <20140429235106.GB5289@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 01:40:08PM +0000, Magnus Damm wrote:
> On Tue, Apr 29, 2014 at 7:43 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Now that SCIF devices are initialised using DT it should
> > be sufficient to use the disabled variant of the clock workaround.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  arch/arm/mach-shmobile/board-marzen-reference.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
> > index 6d34baf..1f14d80 100644
> > --- a/arch/arm/mach-shmobile/board-marzen-reference.c
> > +++ b/arch/arm/mach-shmobile/board-marzen-reference.c
> > @@ -40,12 +40,6 @@ static void __init marzen_init_timer(void)
> >   * devices until they get moved to DT.
> >   */
> >  static const struct clk_name clk_names[] __initconst = {
> > -       { "scif0", NULL, "sh-sci.0" },
> > -       { "scif1", NULL, "sh-sci.1" },
> > -       { "scif2", NULL, "sh-sci.2" },
> > -       { "scif3", NULL, "sh-sci.3" },
> > -       { "scif4", NULL, "sh-sci.4" },
> > -       { "scif5", NULL, "sh-sci.5" },
> >         { "tmu0", NULL, "sh_tmu.0" },
> >         { "tmu1", NULL, "sh_tmu.1" },
> >         { "tmu2", NULL, "sh_tmu.2" },
> > @@ -55,6 +49,12 @@ static const struct clk_name clk_names[] __initconst = {
> >   * This is a really crude hack to work around core platform clock issues
> >   */
> >  static const struct clk_name clk_enables[] __initconst = {
> > +       { "scif0", NULL, "sh-sci.0" },
> > +       { "scif1", NULL, "sh-sci.1" },
> > +       { "scif2", NULL, "sh-sci.2" },
> > +       { "scif3", NULL, "sh-sci.3" },
> > +       { "scif4", NULL, "sh-sci.4" },
> > +       { "scif5", NULL, "sh-sci.5" },
> >         { "sdhi0", NULL, "ffe4c000.sd" },
> >         { "thermal", NULL, "ffc48000.thermal" },
> >  };
> 
> Hi Simon,
> 
> Thanks for your SCIF DT patches for r8a7779. They look good and clean
> in general I think.
> 
> Regarding this specific patch, I'm not sure why you need to perform
> this kind of change. Is it following the same style as other SoCs?
> 
> In my mind the SCIF driver at least used to rely on both Runtime PM
> and the clock framework for clock control so only relying on clock
> framework should be enough for now. The driver may have been updated
> though, but if so we should make sure we follow the same pattern on
> other SoCs as well.

Thanks, I agree this is not needed.
