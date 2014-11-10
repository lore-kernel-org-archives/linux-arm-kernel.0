From: rric@kernel.org (Robert Richter)
Date: Mon, 10 Nov 2014 21:55:18 +0100
Subject: [PATCH] AHCI: Add generic MSI-X interrupt support to SATA PCI
 driver
In-Reply-To: <5460D100.90403@linux.intel.com>
References: <1415597417-10547-1-git-send-email-rric@kernel.org>
 <5460D100.90403@linux.intel.com>
Message-ID: <20141110205518.GY20170@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.11.14 22:51:44, Jiang Liu wrote:
> On 2014/11/10 13:30, Robert Richter wrote:
> > From: Sunil Goutham <sgoutham@cavium.com>

> > +   /* only enable the first entry (entry.entry = 0) */
> > +   rc = pci_enable_msix_exact(pdev, &entry, 1);
> > +   if (rc < 0)
> > +           return rc;
> > +
> > +   pdev->irq = entry.vector;

>       You can't overwrite pci_dev->irq for MSI-X, it's no way to
> recover original irq for INTx after unbinding ahci driver. Instead,
> you may access msi_desc->irq when requesting irq.

Right, I have a version now that determines the irq vector from
pdev->msi_list.

-Robert
