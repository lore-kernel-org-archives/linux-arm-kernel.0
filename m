From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 18 May 2015 22:37:35 +0300
Subject: [PATCH v6 10/25] iommu: exynos: remove useless device_add/remove
 callbacks
In-Reply-To: <20150518170430.GK20611@8bytes.org>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
 <5559D66A.5070406@samsung.com> <20150518170430.GK20611@8bytes.org>
Message-ID: <3790451.FWdEsNZUcL@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

On Monday 18 May 2015 19:04:30 Joerg Roedel wrote:
> On Mon, May 18, 2015 at 02:09:14PM +0200, Marek Szyprowski wrote:
> > > Hmm, will this remove support for iommu-groups in the exynos driver? I
> > > am still working on the default-domain patch-set which makes iommu-group
> > > support mandatory for iommu-drivers.
> > 
> > I you wish, I can leave this code. iommu-groups were not used at all
> > on Exynos, so I thought that there is no point keeping useless code.
> 
> Yes, please keep the iommu-goups support, it will be required at some
> point.

I think the concept of iommu groups isn't very well understood, hence the 
little love it receives from developers who conclude it's useless. I can't 
blame anyone, I don't do any better. Could I convince you to include 
documentation in your next patch series that touches iommu groups ?

Could you please have a look at my "[RFC/PATCH 0/9] IOMMU probe deferral 
support" patch series in the context of iommu groups ? The series pretty much 
drops groups support from the ipmmu-vmsa driver, not because of a real desire 
to do so, but because I wasn't sure how to keep them. Tips would be 
appreciated.

-- 
Regards,

Laurent Pinchart
