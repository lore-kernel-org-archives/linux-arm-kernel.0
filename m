From: guohanjun@huawei.com (Hanjun Guo)
Date: Thu, 3 Aug 2017 21:25:39 +0800
Subject: [PATCH v3 0/5] ACPI: DMA ranges management
In-Reply-To: <20170803123239.11359-1-lorenzo.pieralisi@arm.com>
References: <20170803123239.11359-1-lorenzo.pieralisi@arm.com>
Message-ID: <59832453.2030407@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/8/3 20:32, Lorenzo Pieralisi wrote:
> This patch series is v3 of a previous posting:
>
> v2->v3:
> 	- Fixed DMA masks computation
>         - Fixed size computation overflow in acpi_dma_get_range()
>
> v1->v2:
> 	- Reworked acpi_dma_get_range() flow and logs
> 	- Added IORT named component address limits
> 	- Renamed acpi_dev_get_resources() helper function
> 	- Rebased against v4.13-rc3
>
> v2: http://lkml.kernel.org/r/20170731152323.32488-1-lorenzo.pieralisi at arm.com
> v1: http://lkml.kernel.org/r/20170720144517.32529-1-lorenzo.pieralisi at arm.com
>
> -- Original cover letter --
>
> As reported in:
>
> http://lkml.kernel.org/r/CAL85gmA_SSCwM80TKdkZqEe+S1beWzDEvdki1kpkmUTDRmSP7g at mail.gmail.com
>
> the bus connecting devices to an IOMMU bus can be smaller in size than
> the IOMMU input address bits which results in devices DMA HW bugs in
> particular related to IOVA allocation (ie chopping of higher address
> bits owing to system bus HW capabilities mismatch with the IOMMU).
>
> Fortunately this problem can be solved through an already present but never
> used ACPI 6.2 firmware bindings (ie _DMA object) allowing to define the DMA
> window for a specific bus in ACPI and therefore all upstream devices
> connected to it.
>
> This small patch series enables _DMA parsing in ACPI core code and
> use it in ACPI IORT code in order to detect DMA ranges for devices and
> update their data structures to make them work with their related DMA
> addressing restrictions.
>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Feng Kan <fkan@apm.com>
> Cc: Jon Masters <jcm@redhat.com>
> Cc: Robert Moore <robert.moore@intel.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

with the whole patch set:

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

I tested this patch set with no _DMA in DSDT but with named
component in IORT table, seeing no regressions on D05.

Thanks
Hanjun
