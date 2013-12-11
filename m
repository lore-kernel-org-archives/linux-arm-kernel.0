From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 11 Dec 2013 13:48:01 +0100
Subject: [PATCH 04/15] iommu: shmobile: Enable driver compilation with
 COMPILE_TEST
In-Reply-To: <20131128073651.GE24146@verge.net.au>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1385515117-23664-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131128073651.GE24146@verge.net.au>
Message-ID: <11462751.6CMKaYKG99@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

Could you please pick this patch up for v3.14 ?

On Thursday 28 November 2013 16:36:51 Simon Horman wrote:
> On Wed, Nov 27, 2013 at 02:18:26AM +0100, Laurent Pinchart wrote:
> > This helps increasing build testing coverage.
> > 
> > The driver doesn't compile on non-ARM platforms due to usage of the ARM
> > DMA IOMMU API, restrict compilation to ARM.
> > 
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: iommu at lists.linux-foundation.org
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> 
> > ---
> > 
> >  drivers/iommu/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 3e7fdbb..79bbc21 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -207,6 +207,7 @@ config SHMOBILE_IOMMU
> >  	bool "IOMMU for Renesas IPMMU/IPMMUI"
> >  	default n
> >  	depends on ARM
> > +	depends on SH_MOBILE || COMPILE_TEST
> >  	select IOMMU_API
> >  	select ARM_DMA_USE_IOMMU
> >  	select SHMOBILE_IPMMU

-- 
Regards,

Laurent Pinchart
