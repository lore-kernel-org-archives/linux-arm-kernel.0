From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 10 Apr 2015 20:13:46 +0200
Subject: [PATCH v3 1/4] PCI: X-Gene: Add the APM X-Gene v1 PCIe MSI/MSIX
 termination driver
In-Reply-To: <7923ef6ffd60a7c3de3c8c04fe746bbd3c15b5ac.1428564115.git.dhdang@apm.com>
References: <cover.1428564115.git.dhdang@apm.com>
 <7923ef6ffd60a7c3de3c8c04fe746bbd3c15b5ac.1428564115.git.dhdang@apm.com>
Message-ID: <1428689626.17822.37.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a nit about a license mismatch.

On Thu, 2015-04-09 at 10:05 -0700, Duc Dang wrote:
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
 
> +config PCI_XGENE_MSI
> +	bool "X-Gene v1 PCIe MSI feature"
> +	depends on PCI_XGENE && PCI_MSI

> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile

> +obj-$(CONFIG_PCI_XGENE_MSI) += pci-xgene-msi.o

> --- /dev/null
> +++ b/drivers/pci/host/pci-xgene-msi.c

> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

This states the license of this file is GPL v2 or later.

> +MODULE_LICENSE("GPL v2");

And, according to include/linux/module.h, this states the license of
this driver is GPL v2. So either the comment at the top of this file or
the license ident used in this macro needs to change.

(Now, as far as I can tell, this driver is built-in only. So I think
this macro - and all other module specific code in this file - is
actually unneeded. But I already know Bjorn's position here, so I won't
bother you about that.)

Thanks,


Paul Bolle
