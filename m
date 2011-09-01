From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 1 Sep 2011 16:15:48 +0200
Subject: [PATCH] iommu: omap_iovmm: support non page-aligned buffers in
	iommu_vmap
In-Reply-To: <CAK=WgbY0YTBVbHwHDDa-+8j8d_navvKN=JXFJDpdWp2BX0LFCg@mail.gmail.com>
References: <1314646569-16738-1-git-send-email-ohad@wizery.com>
	<201109011559.33491.laurent.pinchart@ideasonboard.com>
	<CAK=WgbY0YTBVbHwHDDa-+8j8d_navvKN=JXFJDpdWp2BX0LFCg@mail.gmail.com>
Message-ID: <201109011615.49533.laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 September 2011 16:02:35 Ohad Ben-Cohen wrote:
> On Thu, Sep 1, 2011 at 4:59 PM, Laurent Pinchart
> 
> <laurent.pinchart@ideasonboard.com> wrote:
> > It looks good to me.
> 
> Thanks.
> 
> > I haven't tested it though.
> 
> I did, but I always get aligned buffers so my testing is a bit moot. I
> can't see how unmap could work without this patch, though, so I'll
> squash this and re-post.

You can allocate a page-aligned buffer with posix_memalign() and add an offset 
(64 should do the job, smaller values can get rejected by the OMAP3 ISP 
driver).

-- 
Regards,

Laurent Pinchart
