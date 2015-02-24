From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 24 Feb 2015 02:02:57 +0200
Subject: [PATCH v2 linux-next] iommu: Enable LPAE pagetable on ARM only
In-Reply-To: <4372575.Lr7FssDpKu@avalon>
References: <2868840.GyWYJOzqWH@avalon>
 <1424735721-32313-1-git-send-email-vincent.stehle@laposte.net>
 <4372575.Lr7FssDpKu@avalon>
Message-ID: <3203874.zEMjzr0PS0@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vincent,

On Tuesday 24 February 2015 01:58:17 Laurent Pinchart wrote:
> On Tuesday 24 February 2015 00:55:21 Vincent Stehl? wrote:
> > LPAE iommu page table makes sense only for ARM architecture. Add the
> > corresponding dependency in Kconfig (and enable for COMPILE_TEST, too, as
> > per Laurent's suggestion).
> > 
> > Signed-off-by: Vincent Stehl? <vincent.stehle@laposte.net>
> > Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

And I of course spoke too soon :-/

> > ---
> > 
> > Changes since v1:
> > - Add condition on COMPILE_TEST
> > 
> >  drivers/iommu/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index baa0d97..27cd88d 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -22,6 +22,7 @@ config IOMMU_IO_PGTABLE
> > 
> >  config IOMMU_IO_PGTABLE_LPAE
> >  	bool "ARMv7/v8 Long Descriptor Format"
> > +	depends on ARM || COMPILE_TEST

Shouldn't this be ARM || ARM64 || COMPILE_TEST ?

> >  	select IOMMU_IO_PGTABLE
> >  	help
> >  	  Enable support for the ARM long descriptor pagetable format.

-- 
Regards,

Laurent Pinchart
