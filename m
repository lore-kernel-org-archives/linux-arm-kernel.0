From: will.deacon@arm.com (Will Deacon)
Date: Tue, 14 Jun 2016 19:12:14 +0100
Subject: [RFC PATCH v2 10/15] drivers: iommu: arm-smmu-v3: enable ACPI
 driver initialization
In-Reply-To: <1465306270-27076-11-git-send-email-lorenzo.pieralisi@arm.com>
References: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1465306270-27076-11-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20160614181213.GI16531@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 02:31:05PM +0100, Lorenzo Pieralisi wrote:
> On systems booting with ACPI that enable the ARM SMMU components
> in the kernel config options, the ARM SMMU v3 init function
> (ie arm_smmu_init(), that registers the driver and sets-up bus
> iommu operations) does not run only because the device tree interface
> (of_find_matching_node()) fails to find the respective device tree
> nodes for ARM SMMU devices.
> 
> This works as long as there are no ARM SMMU devices to be probed
> with ACPI. If ARM SMMU v3 components are part of the IORT tables,
> for them to be instantiated and probed the function registering
> the ARM SMMU v3 driver must be able to register the driver and
> initialize the bus IOMMU operations accordingly.
> 
> This patch changes the logic in arm-smmu-v3 init call to allow
> for it to be probed in ACPI systems.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
