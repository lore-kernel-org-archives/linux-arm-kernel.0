From: dhdang@apm.com (Duc Dang)
Date: Wed, 18 Mar 2015 10:43:10 -0700
Subject: [PATCH v2 0/4] PCI: X-Gene: Add APM X-Gene v1 MSI/MSIX
 termination driver
In-Reply-To: <cover.1425497218.git.dhdang@apm.com>
References: <1678162.2PJ2o1jRen@wuerfel> <cover.1425497218.git.dhdang@apm.com>
Message-ID: <CADaLND=+Aq-zgMWE6vnn1kt1g2iz1k-AxMj4--kejF-q=f=bfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 4, 2015 at 11:39 AM, Duc Dang <dhdang@apm.com> wrote:
> This patch set adds MSI/MSIX termination driver support for APM X-Gene v1 SoC.
> APM X-Gene v1 SoC supports its own implementation of MSI, which is not compliant
> to GIC V2M specification for MSI Termination.
>
> There is single MSI block in X-Gene v1 SOC which serves all 5 PCIe ports. This MSI
> block supports 2688 MSI termination ports coalesced into 16 physical HW IRQ lines
> and shared across all 5 PCIe ports.
>
> v2 changes:
>         1. Use msi_controller structure
>         2. Remove arch hooks arch_teardown_msi_irqs and arch_setup_msi_irqs
>
>  .../devicetree/bindings/pci/xgene-pci-msi.txt      |  61 ++++
>  MAINTAINERS                                        |   8 +
>  arch/arm64/boot/dts/apm/apm-storm.dtsi             |  27 ++
>  drivers/pci/host/Kconfig                           |   4 +
>  drivers/pci/host/Makefile                          |   1 +
>  drivers/pci/host/pci-xgene-msi.c                   | 393 +++++++++++++++++++++
>  drivers/pci/host/pci-xgene.c                       |  25 ++
>  7 files changed, 519 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
>  create mode 100644 drivers/pci/host/pci-xgene-msi.c
>
> --
> 1.9.1
>
Hi Bjorn, Arnd, and All,

Did you have a chance to take a look at this v2 patch set for X-Gene 1
MSI support?

Thanks,
Duc Dang.
