From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 Mar 2014 17:14:57 +0000
Subject: [PATCH v7 3/3] arm64: Add architecture support for PCI
In-Reply-To: <1394811258-1500-4-git-send-email-Liviu.Dudau@arm.com>
References: <1394811258-1500-1-git-send-email-Liviu.Dudau@arm.com>
 <1394811258-1500-4-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <20140314171457.GK18126@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 03:34:18PM +0000, Liviu Dudau wrote:
> --- /dev/null
> +++ b/arch/arm64/kernel/pci.c
[...]
> +int pci_register_io_range(phys_addr_t address, resource_size_t size)
[...]
> +unsigned long pci_address_to_pio(phys_addr_t address)
[...]
> +void pcibios_fixup_bus(struct pci_bus *bus)
[ actually most of this file ]

Maybe it was raised before already but can we have __weak generic
definitions of these functions? They don't seem to be arm64 specific in
any way.

-- 
Catalin
