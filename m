From: joerg.roedel@amd.com (Joerg Roedel)
Date: Thu, 12 Apr 2012 12:25:05 +0200
Subject: [PATCH] iommu: OMAP: device detach on domain destroy
In-Reply-To: <1333123429-3727-1-git-send-email-omar.luna@linaro.org>
References: <1333123429-3727-1-git-send-email-omar.luna@linaro.org>
Message-ID: <20120412102505.GL2428@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 11:03:49AM -0500, Omar Ramirez Luna wrote:
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

Doesn't apply against 3.4-rc2. Please rebase and send a new version.


	Joerg


-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
