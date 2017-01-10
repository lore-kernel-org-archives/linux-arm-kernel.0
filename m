From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Jan 2017 14:17:48 +0000
Subject: [PATCH v7 19/19] iommu/arm-smmu: Do not advertise
 IOMMU_CAP_INTR_REMAP anymore
In-Reply-To: <1483969570-3154-20-git-send-email-eric.auger@redhat.com>
References: <1483969570-3154-1-git-send-email-eric.auger@redhat.com>
 <1483969570-3154-20-git-send-email-eric.auger@redhat.com>
Message-ID: <20170110141748.GD27365@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 01:46:10PM +0000, Eric Auger wrote:
> IOMMU_CAP_INTR_REMAP has been advertised in arm-smmu(-v3) although
> on ARM this property is not attached to the IOMMU but rather is
> implemented in the MSI controller (GICv3 ITS).
> 
> Now vfio_iommu_type1 checks MSI remapping capability at MSI controller
> level, let's correct this.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 2 --
>  drivers/iommu/arm-smmu.c    | 2 --
>  2 files changed, 4 deletions(-)

Dependent on the previous two VFIO patches:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
