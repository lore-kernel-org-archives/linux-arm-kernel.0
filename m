From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 2 Aug 2017 17:52:18 +0100
Subject: [PATCH v2 0/5] ACPI: DMA ranges management
In-Reply-To: <CAJZ5v0g_NHo5Jnp5HcseS2RQL1PwaewGE6eG6Xn9OafAXwHgkw@mail.gmail.com>
References: <20170731152323.32488-1-lorenzo.pieralisi@arm.com>
 <CAJZ5v0g_NHo5Jnp5HcseS2RQL1PwaewGE6eG6Xn9OafAXwHgkw@mail.gmail.com>
Message-ID: <20170802165218.GA32215@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 08:57:19PM +0200, Rafael J. Wysocki wrote:
> On Mon, Jul 31, 2017 at 5:23 PM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > This patch series is v2 of a previous posting:
> >
> > v1: http://lkml.kernel.org/r/20170720144517.32529-1-lorenzo.pieralisi at arm.com
> >
> > v1->v2:
> >         - Reworked acpi_dma_get_range() flow and logs
> >         - Added IORT named component address limits
> >         - Renamed acpi_dev_get_resources() helper function
> >         - Rebased against v4.13-rc3
> >
> > -- Original cover letter --
> >
> > As reported in:
> >
> > http://lkml.kernel.org/r/CAL85gmA_SSCwM80TKdkZqEe+S1beWzDEvdki1kpkmUTDRmSP7g at mail.gmail.com
> >
> > the bus connecting devices to an IOMMU bus can be smaller in size than
> > the IOMMU input address bits which results in devices DMA HW bugs in
> > particular related to IOVA allocation (ie chopping of higher address
> > bits owing to system bus HW capabilities mismatch with the IOMMU).
> >
> > Fortunately this problem can be solved through an already present but never
> > used ACPI 6.2 firmware bindings (ie _DMA object) allowing to define the DMA
> > window for a specific bus in ACPI and therefore all upstream devices
> > connected to it.
> >
> > This small patch series enables _DMA parsing in ACPI core code and
> > use it in ACPI IORT code in order to detect DMA ranges for devices and
> > update their data structures to make them work with their related DMA
> > addressing restrictions.
> >
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Hanjun Guo <hanjun.guo@linaro.org>
> > Cc: Feng Kan <fkan@apm.com>
> > Cc: Jon Masters <jcm@redhat.com>
> > Cc: Robert Moore <robert.moore@intel.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >
> > Lorenzo Pieralisi (5):
> >   ACPICA: resource_mgr: Allow _DMA method in walk resources
> >   ACPI: Make acpi_dev_get_resources() method agnostic
> >   ACPI: Introduce DMA ranges parsing
> >   ACPI: Make acpi_dma_configure() DMA regions aware
> >   ACPI/IORT: Add IORT named component memory address limits
> 
> Patches [1-3/5] are fine by me, but I need ACKs from the ARM side on
> the last two ones.

Will, Robin, are you ok with this series ?

@Nate: I'd need your tested-by on v2 please (ie IORT named component
address limits handling) before we go ahead.

Thanks,
Lorenzo
