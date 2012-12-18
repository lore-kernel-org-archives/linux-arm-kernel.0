From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 18 Dec 2012 07:50:44 +0100
Subject: [PATCH] ARM: shmobile: r8a7779: Fix PFC - MOD_SEL2 missed an entry
In-Reply-To: <20121218042854.GH29354@verge.net.au>
References: <1353601737-21641-1-git-send-email-phil.edworthy@renesas.com>
 <20121218035144.GC13353@verge.net.au> <20121218042854.GH29354@verge.net.au>
Message-ID: <1990499.FnQH3SnHiY@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Tuesday 18 December 2012 13:28:54 Simon Horman wrote:
> On Tue, Dec 18, 2012 at 12:51:44PM +0900, Simon Horman wrote:
> > On Tue, Dec 18, 2012 at 11:36:10AM +0900, Simon Horman wrote:
> > > On Thu, Nov 22, 2012 at 04:28:57PM +0000, Phil Edworthy wrote:
> > > > The list of functions selected by the MOD_SEL2 register was missing
> > > > an entry. This caused all entries after this to modify the MOD_SEL2
> > > > register incorrectly.
> > > 
> > > Laurent, can you handle this in your series?
> > > I believe it removes this file.
> > 
> > Sorry, I missed the fact that this is for stable.
> > Laurent, can you handle upstream and I'll handle stable?

Sure. I've added the patch to my tree.

> Sorry, yet another thing.
> 
> Phil, could you explain what problems manifest at for users without this
> change? To be included in stable it is important that it solves a problem
> that actually manifests.
> 
> > > > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > > > ---
> > > > 
> > > >  arch/arm/mach-shmobile/pfc-r8a7779.c |    2 +-
> > > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/mach-shmobile/pfc-r8a7779.c
> > > > b/arch/arm/mach-shmobile/pfc-r8a7779.c index 9fac32e4..15f6a48 100644
> > > > --- a/arch/arm/mach-shmobile/pfc-r8a7779.c
> > > > +++ b/arch/arm/mach-shmobile/pfc-r8a7779.c
> > > > @@ -2525,7 +2525,7 @@ static struct pinmux_cfg_reg
> > > > pinmux_config_regs[] = {
> > > > 
> > > >  	    /* SEL_SCIF [2] */
> > > >  	    FN_SEL_SCIF_0, FN_SEL_SCIF_1, FN_SEL_SCIF_2, FN_SEL_SCIF_3,
> > > >  	    /* SEL_CANCLK [2] */
> > > > 
> > > > -	    FN_SEL_CANCLK_0, FN_SEL_CANCLK_1, FN_SEL_CANCLK_2,
> > > > +	    FN_SEL_CANCLK_0, FN_SEL_CANCLK_1, FN_SEL_CANCLK_2, 0,
> > > > 
> > > >  	    /* SEL_CAN0 [1] */
> > > >  	    FN_SEL_CAN0_0, FN_SEL_CAN0_1,
> > > >  	    /* SEL_HSCIF1 [1] */

-- 
Regards,

Laurent Pinchart
