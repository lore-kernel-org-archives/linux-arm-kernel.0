From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 05 Dec 2015 23:22:49 +0100
Subject: [PATCH] ahci: compile out msi/msix infrastructure
In-Reply-To: <20151204195830.2300.48789.stgit@dwillia2-desk3.jf.intel.com>
References: <20151204195830.2300.48789.stgit@dwillia2-desk3.jf.intel.com>
Message-ID: <1540836.svMP4lTcYC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 December 2015 11:58:30 Dan Williams wrote:
> +#ifdef CONFIG_PCI_MSI
> +static inline int ahci_irq_vector(struct ahci_host_priv *hpriv, int port)
> +{
> +       if (hpriv->flags & AHCI_HFLAG_MULTI_MSIX)
> +               return hpriv->msix[i].vector;
> +       else
> +               return hpriv->irq + i;
> +}
> 

My randconfig tests now noticed that 'i' is undeclared here. I suppose it
should be 'port' instead of 'i'?

	Arnd
