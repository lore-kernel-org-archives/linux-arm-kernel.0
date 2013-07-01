From: horms@verge.net.au (Simon Horman)
Date: Mon, 1 Jul 2013 17:23:05 +0900
Subject: [PATCH] ARM: shmobile: r8a73a4: Fix resources for SCIFB0
In-Reply-To: <CANqRtoSq12g-+CC9g9Kz2VpXhGKd=s_ZyHpJ2KDwgV1Lh5t41g@mail.gmail.com>
References: <51D1320D.4010709@igel.co.jp>
 <CANqRtoSq12g-+CC9g9Kz2VpXhGKd=s_ZyHpJ2KDwgV1Lh5t41g@mail.gmail.com>
Message-ID: <20130701082304.GZ14567@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 01, 2013 at 04:55:24PM +0900, Magnus Damm wrote:
> Hi Hayama-san,
> 
> On Mon, Jul 1, 2013 at 4:38 PM, Takanari Hayama <taki@igel.co.jp> wrote:
> > From: Takanari Hayama <taki@igel.co.jp>
> >
> > Fix base address and IRQ resources associated with SCIFB0.
> >
> > Signed-off-by: Takanari Hayama <taki@igel.co.jp>
> > ---
> >  arch/arm/mach-shmobile/setup-r8a73a4.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c
> > b/arch/arm/mach-shmobile/setup-r8a73a4.c
> > index c5a75a7..7f45c2e 100644
> > --- a/arch/arm/mach-shmobile/setup-r8a73a4.c
> > +++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
> > @@ -62,7 +62,7 @@ enum { SCIFA0, SCIFA1, SCIFB0, SCIFB1, SCIFB2, SCIFB3 };
> >  static const struct plat_sci_port scif[] = {
> >         SCIFA_DATA(SCIFA0, 0xe6c40000, gic_spi(144)), /* SCIFA0 */
> >         SCIFA_DATA(SCIFA1, 0xe6c50000, gic_spi(145)), /* SCIFA1 */
> > -       SCIFB_DATA(SCIFB0, 0xe6c50000, gic_spi(145)), /* SCIFB0 */
> > +       SCIFB_DATA(SCIFB0, 0xe6c20000, gic_spi(148)), /* SCIFB0 */
> >         SCIFB_DATA(SCIFB1, 0xe6c30000, gic_spi(149)), /* SCIFB1 */
> >         SCIFB_DATA(SCIFB2, 0xe6ce0000, gic_spi(150)), /* SCIFB2 */
> >         SCIFB_DATA(SCIFB3, 0xe6cf0000, gic_spi(151)), /* SCIFB3 */
> > --
> > 1.8.0
> 
> Thanks for catching this and submitting a fix. I've verified the
> proposed change using the APE6 rev0.7 hardware manual and it looks
> good to me.
> 
> Acked-by: Magnus Damm <damm@opensource.se>

Thanks, I will try and get this included in v3.11 as a fix
and then added to v3.10 stable.
