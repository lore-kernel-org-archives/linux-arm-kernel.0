From: Joerg.Roedel@amd.com (Joerg Roedel)
Date: Wed, 23 May 2012 12:04:54 +0200
Subject: [PATCH] iommu/core: pass a user-provided token to fault handlers
In-Reply-To: <1337620805-30217-1-git-send-email-ohad@wizery.com>
References: <1337620805-30217-1-git-send-email-ohad@wizery.com>
Message-ID: <20120523100454.GI2604@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2012 at 08:20:05PM +0300, Ohad Ben-Cohen wrote:
> Sometimes a single IOMMU user may have to deal with several
> different IOMMU devices (e.g. remoteproc).
> 
> When an IOMMU fault happens, such users have to regain their
> context in order to deal with the fault.
> 
> Users can't use the private fields of neither the iommu_domain nor
> the IOMMU device, because those are already used by the IOMMU core
> and low level driver (respectively).
> 
> This patch just simply allows users to pass a private token (most
> notably their own context pointer) to iommu_set_fault_handler(),
> and then makes sure it is provided back to the users whenever
> an IOMMU fault happens.
> 
> The patch also adopts remoteproc to the new fault handling
> interface, but the real functionality using this (recovery of
> remote processors) will only be added later in a subsequent patch
> set.
> 
> Cc: Fernando Guzman Lugo <fernando.lugo@ti.com>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>

Applied, thanks.


-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
