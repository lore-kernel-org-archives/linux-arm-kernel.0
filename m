From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 8 Sep 2011 16:35:16 -0700
Subject: [RFC PATCH 01/10] OMAP2+: l3-noc: Add support for device-tree
In-Reply-To: <4E693AB6.7050200@ti.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
	<1314191356-10963-2-git-send-email-b-cousson@ti.com>
	<20110908180148.GA2967@ponder.secretlab.ca>
	<4E693AB6.7050200@ti.com>
Message-ID: <20110908233516.GA6401@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2011 at 11:59:18PM +0200, Cousson, Benoit wrote:
> On 9/8/2011 8:01 PM, Grant Likely wrote:
> >On Wed, Aug 24, 2011 at 03:09:07PM +0200, Benoit Cousson wrote:
> >>Add device-tree support for the l3-noc driver.
> >>
> >>Use platform_driver_register to defer the probing at device init
> >>time.
> >>
> >>Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> >>Cc: Tony Lindgren<tony@atomide.com>
> >>Cc: Santosh Shilimkar<santosh.shilimkar@ti.com>
> >>---
> >>  arch/arm/mach-omap2/omap_l3_noc.c |   16 ++++++++++++++--
> >>  1 files changed, 14 insertions(+), 2 deletions(-)
> >>
> >>diff --git a/arch/arm/mach-omap2/omap_l3_noc.c b/arch/arm/mach-omap2/omap_l3_noc.c
> >>index 7b9f190..4630703 100644
> >>--- a/arch/arm/mach-omap2/omap_l3_noc.c
> >>+++ b/arch/arm/mach-omap2/omap_l3_noc.c
> >>@@ -228,16 +228,28 @@ static int __exit omap4_l3_remove(struct platform_device *pdev)
> >>  	return 0;
> >>  }
> >>
> >>+#if defined(CONFIG_OF)
> >>+static const struct of_device_id l3_noc_match[] = {
> >>+	{.compatible = "arteris,noc", },
> >
> >Missing documentation for this compatible property.
> 
> As you already figured out... it will come later.
> 
> >Also, it appears
> >to be rather on the generic side.
> 
> It is indeed a generic IP that will be there on OMAP5 too.

Even for common ip blocks, it is good practice to be specific about
the implementation.  IP block details tend to change from one silicon
design to the next.  Overly generic (optimistic) compatible value names
generally should be avoided.  Instead, backwards compatibility is
achieved by newer devices claiming compatibility with older
implementations in the compatible list.

g.
