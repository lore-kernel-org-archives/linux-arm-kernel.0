From: horms@verge.net.au (Simon Horman)
Date: Thu, 7 Nov 2013 17:52:57 +0900
Subject: [PATCH] ARM: shmobile: r8a7779: Remove unused clock constants
In-Reply-To: <1395939.NimcadHhnk@avalon>
References: <1383720523-9645-1-git-send-email-horms+renesas@verge.net.au>
 <1395939.NimcadHhnk@avalon>
Message-ID: <20131107085253.GE17384@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 01:59:20PM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> Thank you for the patch.
> 
> On Wednesday 06 November 2013 15:48:43 Simon Horman wrote:
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  arch/arm/mach-shmobile/clock-r8a7779.c | 8 --------
> >  1 file changed, 8 deletions(-)
> > 
> > diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c
> > b/arch/arm/mach-shmobile/clock-r8a7779.c index b7ce0e7..3083c70 100644
> > --- a/arch/arm/mach-shmobile/clock-r8a7779.c
> > +++ b/arch/arm/mach-shmobile/clock-r8a7779.c
> > @@ -47,17 +47,9 @@
> > 
> >  #define MD(nr)	BIT(nr)
> > 
> > -#define FRQMR		IOMEM(0xffc80014)
> >  #define MSTPCR0		IOMEM(0xffc80030)
> >  #define MSTPCR1		IOMEM(0xffc80034)
> >  #define MSTPCR3		IOMEM(0xffc8003c)
> > -#define MSTPSR1		IOMEM(0xffc80044)
> > -#define MSTPSR4		IOMEM(0xffc80048)
> > -#define MSTPSR6		IOMEM(0xffc8004c)
> > -#define MSTPCR4		IOMEM(0xffc80050)
> > -#define MSTPCR5		IOMEM(0xffc80054)
> > -#define MSTPCR6		IOMEM(0xffc80058)
> > -#define MSTPCR7		IOMEM(0xffc80040)
> 
> It has been pointed out to me that the CPG requires waiting for clocks to be 
> enabled on all R-Mobile and R-Car SoCs. I've send a patch series to implement 
> this for r8a7790 ("[PATCH 0/2] ARM: shmobile: r8a7790: Wait for status on all 
> MSTP clocks"). Should we expand that to the other SoCs as well ? In that case 
> the constants would be needed.

That is a good question.

I am unsure if waiting is only required for Gen2 R-Car SoCs or
Gen1 as well. If it is requried for Gen1 then it would
make sense to extend the coverage of your series to H1 (r8a7779).
