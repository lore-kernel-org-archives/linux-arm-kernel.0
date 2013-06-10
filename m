From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 10 Jun 2013 14:31:31 +0200
Subject: [PATCH 1/8] ARM: shmobile: sh73a0 pinmux platform device cleanup
In-Reply-To: <20130604132058.GE3068@verge.net.au>
References: <1369645252-3847-1-git-send-email-horms+renesas@verge.net.au>
 <20130604052043.GX23054@verge.net.au> <20130604132058.GE3068@verge.net.au>
Message-ID: <1722811.MCTrRecTtK@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Tuesday 04 June 2013 22:20:59 Simon Horman wrote:
> On Tue, Jun 04, 2013 at 02:20:43PM +0900, Simon Horman wrote:
> > On Mon, May 27, 2013 at 09:02:43PM -0700, Olof Johansson wrote:
> > > On Mon, May 27, 2013 at 06:13:22PM +0400, Sergei Shtylyov wrote:
> > > > On 27-05-2013 13:00, Simon Horman wrote:
> > > > >From: Magnus Damm <damm@opensource.se>
> > > > >
> > > > >Use DEFINE_RES_MEM() and platform_device_register_simple()
> > > > >to save a couple of lines of code.
> > > > >
> > > > >Signed-off-by: Magnus Damm <damm@opensource.se>
> > > > >Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > > >---
> > > > >
> > > > >  arch/arm/mach-shmobile/setup-sh73a0.c |   25
> > > > >  ++++++-------------------
> > > > >  1 file changed, 6 insertions(+), 19 deletions(-)
> > > > >
> > > > >diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c
> > > > >b/arch/arm/mach-shmobile/setup-sh73a0.c index fdf3894..f8f4261
> > > > >100644
> > > > >--- a/arch/arm/mach-shmobile/setup-sh73a0.c
> > > > >+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
> > > > >@@ -61,29 +61,16 @@ void __init sh73a0_map_io(void)
> > > > 
> > > > [...]
> > > > 
> > > > >+/* PFC */
> > > > >+static const struct resource pfc_resources[] = {
> > > > >
> > > >    Should have been annotated as __initdata... too late, need
> > > > 
> > > > another patch.
> > > 
> > > See comments on other patches/pull requests, I think there's time to
> > > revisit this. I.e. I'll hold off on pulling this based on the other
> > > feedback.
> >
> > As I am respining I will fix this.
> > 
> > However, it had been reviewed and I think that ordinarily
> > it would be reasonable to perform further clean-up
> > work in a subsequent patch.
> 
> I decided to simply drop the patch and revisit it later.

This patch (as well as the sh7372 equivalent) is pretty simple. What about 
just adding __initdata and resubmitting them ? Otherwise they will get lost.

-- 
Regards,

Laurent Pinchart
