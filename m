From: mchehab@redhat.com (Mauro Carvalho Chehab)
Date: Thu, 18 Oct 2012 17:56:59 -0300
Subject: [PATCH 3/6] ARM: OMAP2+: Move plat/iovmm.h to
 include/linux/omap-iommu.h
In-Reply-To: <20121018202842.11834.14375.stgit@muffinssi.local>
References: <20121018202707.11834.1438.stgit@muffinssi.local>
 <20121018202842.11834.14375.stgit@muffinssi.local>
Message-ID: <20121018175659.431fe0b1@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Em Thu, 18 Oct 2012 13:28:42 -0700
Tony Lindgren <tony@atomide.com> escreveu:

> Looks like the iommu framework does not have generic functions
> exported for all the needs yet. The hardware specific functions
> are defined in files like intel-iommu.h and amd-iommu.h. Follow
> the same standard for omap-iommu.h.
> 
> This is needed because we are removing plat and mach includes
> for ARM common zImage support. Further work should continue
> in the iommu framework context as only pure platform data will
> be communicated from arch/arm/*omap*/* code to the iommu
> framework.
> 
> Cc: Joerg Roedel <joerg.roedel@amd.com>
> Cc: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: Ido Yariv <ido@wizery.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Mauro Carvalho Chehab <mchehab@infradead.org>
> Cc: Omar Ramirez Luna <omar.luna@linaro.org>
> Cc: linux-media at vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/iommu2.c               |    1 
>  arch/arm/plat-omap/include/plat/iommu.h    |   10 +--
>  arch/arm/plat-omap/include/plat/iovmm.h    |   89 ----------------------------
>  drivers/iommu/omap-iommu-debug.c           |    2 -
>  drivers/iommu/omap-iommu.c                 |    1 
>  drivers/iommu/omap-iovmm.c                 |   46 ++++++++++++++
>  drivers/media/platform/omap3isp/isp.c      |    1 
>  drivers/media/platform/omap3isp/isp.h      |    2 -
>  drivers/media/platform/omap3isp/ispccdc.c  |    1 
>  drivers/media/platform/omap3isp/ispstat.c  |    1 
>  drivers/media/platform/omap3isp/ispvideo.c |    2 -

Acked-by: Mauro Carvalho Chehab <mchehab@redhat.com>

It is better if you send this entire series through the ARM tree, keeping
this hole series altogether (and avoiding the risk of breaking bisectability
if it goes through separate trees). So, you can add my ack for those header
moves for drivers/media/platform/*.

Regards,
Mauro

-- 

Cheers,
Mauro
