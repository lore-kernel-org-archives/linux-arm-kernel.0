From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 14 May 2014 16:01:31 +0100
Subject: [PATCHv2 2/4] ARM: mm: allow sub-architectures to override PCI
 I/O memory type
In-Reply-To: <1399975839-5311-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399975839-5311-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1399975839-5311-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140514150130.GF19866@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 11:10:37AM +0100, Thomas Petazzoni wrote:
> Due to a design incompatibility between the PCIe Marvell controller
> and the Cortex-A9, stressing PCIe devices with a lot of traffic
> quickly causes a deadlock.
> 
> One part of the workaround for this is to have all PCIe regions mapped
> as MT_MEMORY_SO instead of MT_DEVICE. While the arch_ioremap_caller()
> mechanism allows sub-architecture code to override ioremap(), used to
> map PCIe memory regions, there isn't such a mechanism to override the
> behavior of pci_ioremap_io().
> 
> This commit adds the arch_pci_ioremap_mem_type variable, initialized
> to MT_DEVICE by default, and that sub-architecture code can
> override. We have chosen to expose a single variable rather than
> offering the possibility of overriding the entire pci_ioremap_io(),
> because implementing pci_ioremap_io() requires calling functions
> (get_mem_type()) that are private to the arch/arm/mm/ code.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
