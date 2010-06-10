From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 10 Jun 2010 10:34:54 +0200
Subject: [PATCH 1/3] mx25: add watchdog clock
In-Reply-To: <20100610082756.GD31840@jasper.tkos.co.il>
References: <cover.1276081393.git.baruch@tkos.co.il>
	<bc8385e0c903851918839a66f9e582a507434e93.1276081393.git.baruch@tkos.co.il>
	<20100610081042.GB5333@pengutronix.de>
	<20100610081806.GC31840@jasper.tkos.co.il>
	<20100610082145.GC5333@pengutronix.de>
	<20100610082756.GD31840@jasper.tkos.co.il>
Message-ID: <20100610083454.GD5333@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 10, 2010 at 11:27:56AM +0300, Baruch Siach wrote:
> Hi Wolfram,
> On Thu, Jun 10, 2010 at 10:21:45AM +0200, Wolfram Sang wrote:
> > On Thu, Jun 10, 2010 at 11:18:06AM +0300, Baruch Siach wrote:
> > > On Thu, Jun 10, 2010 at 10:10:42AM +0200, Wolfram Sang wrote:
> > > > On Wed, Jun 09, 2010 at 02:07:00PM +0300, Baruch Siach wrote:
> > > > > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > > > > ---
> > > > >  arch/arm/mach-mx25/clock.c |    2 ++
> > > > >  1 files changed, 2 insertions(+), 0 deletions(-)
> > > > > 
> > > > > diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
> > > > > index 1550149..f9662d9 100644
> > > > > --- a/arch/arm/mach-mx25/clock.c
> > > > > +++ b/arch/arm/mach-mx25/clock.c
> > > > > @@ -191,6 +191,7 @@ DEFINE_CLOCK(i2c_clk,	 0, CCM_CGCR0,  6, get_rate_i2c, NULL, NULL);
> > > > >  DEFINE_CLOCK(fec_clk,	 0, CCM_CGCR1, 15, get_rate_ipg, NULL, &fec_ahb_clk);
> > > > >  DEFINE_CLOCK(dryice_clk, 0, CCM_CGCR1,  8, get_rate_ipg, NULL, NULL);
> > > > >  DEFINE_CLOCK(lcdc_clk,	 0, CCM_CGCR1, 29, get_rate_lcdc, NULL, &lcdc_per_clk);
> > > > > +DEFINE_CLOCK(wdt_clk,    0, CCM_CGCR1, 19, get_rate_ipg, NULL,  NULL);
> > > > 
> > > > That is clk_gpt1 according to my RM (Rev 1)?
> > > 
> > > Right. It should be CCM_CGCR2. I'll fix this.
> > > 
> > > Note that this bit is marked "Reserved" in the RM. But a look at the Freescale 
> > > supplied BSP reveals the following line in crm_regs.h:
> > > 
> > > #define MXC_CCM_CGCR2_WDOG_OFFSET        (51-32)
> > 
> > OK. Please add this information also in a short comment above the clock
> > definition.
> 
> There are 12 other IPG clock bit that are wrongly marked "Reserved" in the RM.  
> Should we add a comment for each?

Hmm, an introductory "global" comment should do IMO. Like "Some bits are marked
reserved in the reference manual (v1), but have been used in the official
BSPs, so we copied that". What do you think?

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100610/1619f567/attachment.sig>
