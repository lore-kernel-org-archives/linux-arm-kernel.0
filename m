From: will.deacon@arm.com (Will Deacon)
Date: Thu, 10 Aug 2017 18:27:23 +0100
Subject: [PATCH v6 3/3] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
 erratum 161010801
In-Reply-To: <20170809100715.870516-4-shameerali.kolothum.thodi@huawei.com>
References: <20170809100715.870516-1-shameerali.kolothum.thodi@huawei.com>
 <20170809100715.870516-4-shameerali.kolothum.thodi@huawei.com>
Message-ID: <20170810172723.GD9980@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 09, 2017 at 11:07:15AM +0100, Shameer Kolothum wrote:
> The HiSilicon erratum 161010801 describes the limitation of HiSilicon
> platforms Hip06/Hip07 to support the SMMU mappings for MSI transactions.
> 
> On these platforms GICv3 ITS translator is presented with the deviceID
> by extending the MSI payload data to 64 bits to include the deviceID.
> Hence, the PCIe controller on this platforms has to differentiate the
> MSI payload against other DMA payload and has to modify the MSI payload.
> This basically makes it difficult for this platforms to have a SMMU
> translation for MSI.
> 
> This patch implements a ACPI table based quirk to reserve the hw msi
> regions in the smmu-v3 driver which means these address regions will
> not be translated and will be excluded from iova allocations.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)

Please can you also add a devicetree binding with corresponding
documentation to enable this workaround on non-ACPI based systems too? It
should be straightforward if you update the arm_smmu_options table.

Thanks,

Will
