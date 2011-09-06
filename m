From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Tue, 6 Sep 2011 12:15:35 +0200
Subject: [PATCH/RFC 0/7] iommu: fixes & extensions
In-Reply-To: <1314984756-4400-1-git-send-email-ohad@wizery.com>
References: <1314984756-4400-1-git-send-email-ohad@wizery.com>
Message-ID: <20110906101535.GT16691@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 02, 2011 at 01:32:29PM -0400, Ohad Ben-Cohen wrote:
> 5 first patches are relatively small iommu fixes/cleanups.
> 
> 2 last patches are proposals for core iommu extensions:
> - Add fault report mechanism, needed for recovery of remote processors
>   trying to access unmapped addresses.
> - Add splitting of memory regions to pages in the iommu core itself
>   (according to hardware capabilities as advertised by the iommu drivers).
>   This is needed to prevent duplication of this logic by
>   the iommu users/drivers themselves.
> 
> The patches are based on Joerg's arm/omap branch.
> 
> Tested with OMAP3 (omap3isp) + OMAP4 (rpmsg/remoteproc).
> 
> Laurent Pinchart (1):
>   iommu/omap-iovmm: support non page-aligned buffers in iommu_vmap
> 
> Ohad Ben-Cohen (6):
>   iommu/omap: cleanup: remove a redundant 'return' statement
>   iommu/core: use the existing IS_ALIGNED macro
>   iommu/omap: ->unmap() should return order of unmapped page
>   iommu/msm: ->unmap() should return order of unmapped page
>   iommu/core: add fault reporting
>   iommu/core: split mapping to page sizes as supported by the hardware

Ok, I applied 1-5 to their respective branches. Patch 6 needs some more
discussion to make sure the interface is generally usable. Patch 7 seems
to be a starting point for now. This definitly requires conversion of
the other IOMMU drivers too.
Please make individual patch-sets from patch 6 and 7 respectivly.

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
