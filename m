From: joerg.roedel@amd.com (Joerg Roedel)
Date: Thu, 19 Apr 2012 15:09:54 +0200
Subject: [PATCH v2] iommu: OMAP: device detach on domain destroy
In-Reply-To: <1334772581-32015-1-git-send-email-omar.luna@linaro.org>
References: <1334772581-32015-1-git-send-email-omar.luna@linaro.org>
Message-ID: <20120419130954.GD2428@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 01:09:41PM -0500, Omar Ramirez Luna wrote:
> 'domain_destroy with devices attached' case isn't yet handled, instead
> code assumes that the device was already detached.
> 
> If the domain is destroyed the hardware still has access to invalid
> pointers to its page table and internal iommu object. In order to
> detach the users we need to track devices using the iommu, current
> use cases only have one user of iommu per instance. When required
> this can evolve to a list with the devices using the iommu_dev.
> 
> Reported-by: Joerg Roedel <joro@8bytes.org>
> Reviewed-by: Ohad Ben-Cohen <ohad@wizery.com>
> Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>
> ---
> 
> v2: rebased onto v3.4-rc2

Applied, thanks.

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
