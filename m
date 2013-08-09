From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 9 Aug 2013 07:42:51 -0400
Subject: [PATCHv8 04/10] of: pci: add registry of MSI chips
In-Reply-To: <1376027346.32100.8.camel@pasglop>
References: <1376000268-18397-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1376000268-18397-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <1376027346.32100.8.camel@pasglop>
Message-ID: <20130809114251.GQ8204@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Fri, Aug 09, 2013 at 03:49:06PM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2013-08-09 at 00:17 +0200, Thomas Petazzoni wrote:
> > 
> > +#if defined(CONFIG_OF) && defined(CONFIG_PCI_MSI)
> > +int of_pci_msi_chip_add(struct msi_chip *chip);
> > +void of_pci_msi_chip_remove(struct msi_chip *chip);
> > +struct msi_chip *of_pci_find_msi_chip_by_node(struct device_node
> > *of_node);
> > +#else
> > +static inline int of_pci_msi_chip_add(struct msi_chip *chip) { return
> > -EINVAL; }
> > +static inline void of_pci_msi_chip_remove(struct msi_chip *chip) { }
> 
> Missing a ; at the end of the above line... breaks the build of
> CONFIG_PCI_MSI is not set.

If this is the same error Randy reported yesterday from -next, I'll just
fix it up when I pull it in.

thx,

Jason.
