From: horms@verge.net.au (Simon Horman)
Date: Fri, 22 Aug 2014 12:53:13 +0900
Subject: [PATCH repost] ARM: shmobile: sh73a0: Remove spurious 0x from
 SCIFB clock name
In-Reply-To: <20140818235634.GK1623@verge.net.au>
References: <cover.1406766463.git.horms+renesas@verge.net.au>
 <20140731004246.GA31860@verge.net.au>
 <CAMuHMdWS14CsDvk+cTYJ7JeX0_3oQdfsRC__Hofmv54uOOtG1Q@mail.gmail.com>
 <20140818235634.GK1623@verge.net.au>
Message-ID: <20140822035313.GP9099@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 08:56:34AM +0900, Simon Horman wrote:
> Hi Geert, thanks for noting that.
> 
> I will add this back to the devel branch in the renesas tree.
> 
> Olof, could you pick up the patch below for v3.17-rcX?

Olof, I have two more clock fixes for v3.17.
I'll send a pull request for them and the one below once
things have sat in next for a bit.

> 
> On Mon, Aug 18, 2014 at 10:32:19AM +0200, Geert Uytterhoeven wrote:
> > Hi Simon, Olof,
> > 
> > On Thu, Jul 31, 2014 at 2:42 AM, Simon Horman
> > <horms+renesas@verge.net.au> wrote:
> > > A stray '0x' crept into a0f7e7496d56ac2d ("ARM: shmobile: sh73a0: add CMT1
> > > clock support for DT"). This  patch removes it.
> > >
> > > This change should not have any run-time affect at this time as
> > > the clock in question is used by a SCIF device that is not enabled by
> > > default.
> > >
> > > Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > ---
> > >  arch/arm/mach-shmobile/clock-sh73a0.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > Hi Olof,
> > >
> > > this is a repost of the patch you asked for so you can apply it directly
> > > rather than as pulling a pull request.
> > 
> > It seems Olof missed this one.
> > As a consequence, we now have the bad version in v3.17-rc1, and in
> > renesas-devel-20140818-v3.17-rc1.
> > 
> > > diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
> > > index 0d77f65..b0993a5 100644
> > > --- a/arch/arm/mach-shmobile/clock-sh73a0.c
> > > +++ b/arch/arm/mach-shmobile/clock-sh73a0.c
> > > @@ -644,7 +644,7 @@ static struct clk_lookup lookups[] = {
> > >         CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP207]), /* SCIFA5 */
> > >         CLKDEV_DEV_ID("e6cb0000.serial", &mstp_clks[MSTP207]), /* SCIFA5 */
> > >         CLKDEV_DEV_ID("sh-sci.8", &mstp_clks[MSTP206]), /* SCIFB */
> > > -       CLKDEV_DEV_ID("0xe6c3000.serial", &mstp_clks[MSTP206]), /* SCIFB */
> > > +       CLKDEV_DEV_ID("e6c3000.serial", &mstp_clks[MSTP206]), /* SCIFB */
> > >         CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP204]), /* SCIFA0 */
> > >         CLKDEV_DEV_ID("e6c40000.serial", &mstp_clks[MSTP204]), /* SCIFA0 */
> > >         CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP203]), /* SCIFA1 */
> > > --
> > > 2.0.1
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> > > the body of a message to majordomo at vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > Gr{oetje,eeting}s,
> > 
> >                         Geert
> > 
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> > 
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> >                                 -- Linus Torvalds
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
