From: tony@atomide.com (Tony Lindgren)
Date: Thu, 18 Oct 2012 09:25:12 -0700
Subject: [PATCH 3/4] ARM: OMAP2+: Move iommu/iovmm headers to platform_data
In-Reply-To: <1418726.Yza1yb71Ul@avalon>
References: <20121016003513.19701.71718.stgit@muffinssi.local>
 <20121016003640.19701.51749.stgit@muffinssi.local>
 <1418726.Yza1yb71Ul@avalon>
Message-ID: <20121018162512.GD30550@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [121018 06:45]:
> Hi,
> 
> On Monday 15 October 2012 17:36:40 Tony Lindgren wrote:
> > From: Ido Yariv <ido@wizery.com>
> > 
> > Move iommu/iovmm headers from plat/ to platform_data/ as part of the
> > single zImage work.
> 
> Is that really where those headers belong ? iommu-omap.h contains far more 
> than platform data, and iovmm-omap.h contains no platform data at all.

Hmm I though that was already fixed by Ido but looks like there are
non-platform data things still remaining there.

Looking at arch/arm/mach-omap2/iommu2.c it seems that it should moved to
drivers/iommu/omap-iommu2.c and that way most of the header can be local
in drivers/iommu/omap-iommu.h. I'll do some patches for that and repost.

Thanks,

Tony
