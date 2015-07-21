From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 22 Jul 2015 00:02:50 +0200 (CEST)
Subject: [RFC Patch V1 09/12] genirq: Move msi_list from struct pci_dev
 to struct device
In-Reply-To: <20150710001936.GD6957@windriver.com>
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
 <1436428847-8886-10-git-send-email-jiang.liu@linux.intel.com>
 <20150710001936.GD6957@windriver.com>
Message-ID: <alpine.DEB.2.11.1507220000260.18576@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 9 Jul 2015, Paul Gortmaker wrote:

> [[RFC Patch V1 09/12] genirq: Move msi_list from struct pci_dev to struct device] On 09/07/2015 (Thu 16:00) Jiang Liu wrote:
> 
> > Move msi_list from struct pci_dev into struct device, so we could support
> > non-PCI-device based generic MSI interrupts.
> 
> This is not just a simple move, as the new instances are within a
> Kconfig option.  I did not get the 0/12 so I don't know if this is
> expected, but the commit log here does not seem stand-alone enough
> to get through on its own merits; it needs more details.

config PCI_MSI
       select GENERIC_MSI_IRQ

So it's not changing anything, but I agree it might be mentioned in
the changelog.
 
Thanks,

	tglx
