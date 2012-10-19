From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Oct 2012 09:17:43 -0700
Subject: [PATCH 5/6] ARM: OMAP2+: Make some definitions local
In-Reply-To: <2153737.CkcY4HqKKl@avalon>
References: <20121018202707.11834.1438.stgit@muffinssi.local>
 <20121018202848.11834.17893.stgit@muffinssi.local>
 <2153737.CkcY4HqKKl@avalon>
Message-ID: <20121019161743.GD4730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [121019 02:45]:
> On Thursday 18 October 2012 13:28:48 Tony Lindgren wrote:
> > @@ -117,13 +112,6 @@ static inline struct omap_iommu
> > *dev_to_omap_iommu(struct device *dev) }
> >  #endif
> > 
> > -/* IOMMU errors */
> > -#define OMAP_IOMMU_ERR_TLB_MISS		(1 << 0)
> > -#define OMAP_IOMMU_ERR_TRANS_FAULT	(1 << 1)
> > -#define OMAP_IOMMU_ERR_EMU_MISS		(1 << 2)
> > -#define OMAP_IOMMU_ERR_TBLWALK_FAULT	(1 << 3)
> > -#define OMAP_IOMMU_ERR_MULTIHIT_FAULT	(1 << 4)
> > -
> 
> I'll use those in the tidspbridge driver, in patches that I plan to push soon.
> 
> I will apply this patch set on top of mine, see what breaks. Would you like me 
> to propose a modified version of this set, or add additional patches in my set 
> ?

Sure, let's try to expose only the minimal amount of omap
iommu things with this patch set so we don't break things.
Then the iommu development can continue on it's own independent
of the core omap code except for the platform data.

But again, if there are nasty layering violations using this
code, I would just remove those features. Those things tend to
just get worse unless they are fixed properly to start with.

Regards,

Tony
