From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 19 Jul 2016 16:17:53 -0500
Subject: [RFC PATCH 0/3] ECAM quirks handling for ARM64 platforms
In-Reply-To: <1464856864-18049-1-git-send-email-tn@semihalf.com>
References: <1464856864-18049-1-git-send-email-tn@semihalf.com>
Message-ID: <20160719211753.GA17840@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2016 at 10:41:00AM +0200, Tomasz Nowicki wrote:
> This series bases on pending ACPI PCI support for ARM64:
> https://lkml.org/lkml/2016/5/30/468
> 
> Quirk handling relies on an idea of matching MCFG OEM ID and OEM revision
> (the ones from standard header of MCFG table). Linker section is used
> so that quirks can be registered using special macro (see patches) and
> kept self contained.
> 
> As an example, last patch presents above mechanism usage for ThunderX PEM driver.
> 
> Tomasz Nowicki (3):
>   pci, acpi: Match PCI config space accessors against platfrom specific
>     ECAM quirks.
>   arm64, pci: Start using quirks handling for ACPI based PCI host
>     controller.
>   pci, pci-thunder-pem: Add ACPI support for ThunderX PEM.
> 
>  arch/arm64/kernel/pci.c            |   7 +-
>  drivers/acpi/pci_mcfg.c            |  32 +++++++++
>  drivers/pci/host/pci-thunder-pem.c | 132 +++++++++++++++++++++++++++++++++----
>  include/asm-generic/vmlinux.lds.h  |   7 ++
>  include/linux/pci-acpi.h           |  19 ++++++
>  5 files changed, 181 insertions(+), 16 deletions(-)

Is this series superceded by Dongdong's series of 6/13 ("[RFC,V2,1/2]
ACPI/PCI: Match PCI config space accessors against platfrom specific ECAM
quirks")?
