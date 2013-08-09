From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 09 Aug 2013 15:49:06 +1000
Subject: [PATCHv8 04/10] of: pci: add registry of MSI chips
In-Reply-To: <1376000268-18397-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1376000268-18397-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1376000268-18397-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1376027346.32100.8.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-08-09 at 00:17 +0200, Thomas Petazzoni wrote:
> 
> +#if defined(CONFIG_OF) && defined(CONFIG_PCI_MSI)
> +int of_pci_msi_chip_add(struct msi_chip *chip);
> +void of_pci_msi_chip_remove(struct msi_chip *chip);
> +struct msi_chip *of_pci_find_msi_chip_by_node(struct device_node
> *of_node);
> +#else
> +static inline int of_pci_msi_chip_add(struct msi_chip *chip) { return
> -EINVAL; }
> +static inline void of_pci_msi_chip_remove(struct msi_chip *chip) { }

Missing a ; at the end of the above line... breaks the build of
CONFIG_PCI_MSI is not set.

> +static inline struct msi_chip *
> +of_pci_find_msi_chip_by_node(struct device_node *of_node) { return
> NULL };
> +#endif
> +
>  #endif
