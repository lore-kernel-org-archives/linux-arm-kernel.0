From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Wed, 14 Sep 2011 17:39:47 +0200
Subject: [PATCH v2 2/2] iommu/omap: migrate to the generic fault report
	mechanism
In-Reply-To: <1315941989-17199-1-git-send-email-ohad@wizery.com>
References: <1315941989-17199-1-git-send-email-ohad@wizery.com>
Message-ID: <20110914153947.GX11701@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2011 at 03:26:29PM -0400, Ohad Ben-Cohen wrote:
> Start using the generic fault report mechanism, as provided by
> the IOMMU core, and remove its now-redundant omap_iommu_set_isr API.
> 
> Currently we're only interested in letting upper layers know about the
> fault, so in case the faulting device is a remote processor, they could
> restart it.
> 
> Dynamic PTE/TLB loading is not supported.
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
>  arch/arm/plat-omap/include/plat/iommu.h |    3 +--
>  drivers/iommu/omap-iommu.c              |   31 +++----------------------------
>  2 files changed, 4 insertions(+), 30 deletions(-)

Applied both to new branch iommu/fault-reporting and merged into my next
branch. Thanks Ohad.

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
