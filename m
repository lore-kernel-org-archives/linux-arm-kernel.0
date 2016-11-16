From: rafael@kernel.org (Rafael J. Wysocki)
Date: Wed, 16 Nov 2016 01:56:35 +0100
Subject: [PATCH v7 16/16] drivers: acpi: iort: introduce
 iort_iommu_configure
In-Reply-To: <20161109141948.19244-17-lorenzo.pieralisi@arm.com>
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
 <20161109141948.19244-17-lorenzo.pieralisi@arm.com>
Message-ID: <CAJZ5v0jmEi+PZ8gGBYOjQi0CZ+0PNEZZ2uHGLcavtZWH+iiXTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 9, 2016 at 3:19 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> DT based systems have a generic kernel API to configure IOMMUs
> for devices (ie of_iommu_configure()).
>
> On ARM based ACPI systems, the of_iommu_configure() equivalent can
> be implemented atop ACPI IORT kernel API, with the corresponding
> functions to map device identifiers to IOMMUs and retrieve the
> corresponding IOMMU operations necessary for DMA operations set-up.
>
> By relying on the iommu_fwspec generic kernel infrastructure,
> implement the IORT based IOMMU configuration for ARM ACPI systems
> and hook it up in the ACPI kernel layer that implements DMA
> configuration for a device.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Tomasz Nowicki <tn@semihalf.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

For the ACPI core part:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
