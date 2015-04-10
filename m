From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Fri, 10 Apr 2015 09:51:59 +0200
Subject: [PATCH 0/5] PCI: st: provide support for dw pcie
In-Reply-To: <1428651507-32554-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1428651507-32554-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <CAG374jDqbubBQZabqchEEpUO8YofMu=OSuei-Nt_98y7=YhtiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Sorry i missed v3 prefix on the title, don't review this i will send a
new patchset.

BR

Gabriel

On 10 April 2015 at 09:38, Gabriel FERNANDEZ <gabriel.fernandez@st.com> wrote:
> Changes in v3:
>  - Remove power management functions (was not fully tested)
>  - Remove configuration space range from dt binding
>  - Remove pci_common_init_dev() call in pcie-designware.c to avoid
>    default IO space declaration.
>
> Changes in v2:
>  - comestic corrections in device tree binding
>  - add pci-st.c into MAINTAINERS
>  - remove st_pcie_ops structure to avoid another level of indirection
>  - remove nasty busy-loop
>  - remove useless test using virt_to_phys()
>  - move disable io support into dw-pcie driver
>
> I don't change the st_pcie_abort_handler() function because abort handling
> is masked during boot.
>
>
> This patch-set introduces a STMicroelectronics PCIe controller.
> It's based on designware PCIe driver.
>
> Gabriel Fernandez (5):
>   ARM: STi: Kconfig update for PCIe support
>   PCI: st: Add Device Tree bindings for sti pcie
>   PCI: st: Provide support for the sti PCIe controller
>   pci: designware: remove pci_common_init_dev()
>   MAINTAINERS: Add pci-st.c to ARCH/STI architecture
>
>  Documentation/devicetree/bindings/pci/st-pcie.txt |  53 ++
>  MAINTAINERS                                       |   1 +
>  arch/arm/mach-sti/Kconfig                         |   2 +
>  drivers/pci/host/Kconfig                          |   9 +
>  drivers/pci/host/Makefile                         |   1 +
>  drivers/pci/host/pci-st.c                         | 583 ++++++++++++++++++++++
>  drivers/pci/host/pcie-designware.c                |  62 +--
>  drivers/pci/host/pcie-designware.h                |   2 +
>  8 files changed, 683 insertions(+), 30 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/st-pcie.txt
>  create mode 100644 drivers/pci/host/pci-st.c
>
> --
> 1.9.1
>
