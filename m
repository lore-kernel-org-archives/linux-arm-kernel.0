From: will.deacon@arm.com (Will Deacon)
Date: Fri, 18 Nov 2016 14:50:41 +0000
Subject: [PATCH v8 06/16] drivers: iommu: arm-smmu-v3: convert struct
 device of_node to fwnode usage
In-Reply-To: <20161116152936.22955-7-lorenzo.pieralisi@arm.com>
References: <20161116152936.22955-1-lorenzo.pieralisi@arm.com>
 <20161116152936.22955-7-lorenzo.pieralisi@arm.com>
Message-ID: <20161118145040.GS13470@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 03:29:26PM +0000, Lorenzo Pieralisi wrote:
> Current ARM SMMU v3 driver rely on the struct device.of_node pointer for
> device look-up and iommu_ops retrieval.
> 
> In preparation for ACPI probing enablement, convert the driver to use
> the struct device.fwnode member for device and iommu_ops look-up so that
> the driver infrastructure can be used also on systems that do not
> associate an of_node pointer to a struct device (eg ACPI), making the
> device look-up and iommu_ops retrieval firmware agnostic.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Tomasz Nowicki <tn@semihalf.com>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Tomasz Nowicki <tn@semihalf.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
