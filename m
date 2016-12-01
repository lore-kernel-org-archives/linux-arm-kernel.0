From: hch@lst.de (Christoph Hellwig)
Date: Thu, 1 Dec 2016 09:52:43 +0100
Subject: [PATCH] PCI:MSI Return -ENOSPC when requested vectors is not
 enough
In-Reply-To: <1480558504-18691-1-git-send-email-dennis.chen@arm.com>
References: <1480558504-18691-1-git-send-email-dennis.chen@arm.com>
Message-ID: <20161201085243.GA24684@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dennis,

I've fixed ahci to treat all errors the same in the meantime, please
try latest Linux tree.  That being said I don't like the different
error returns from __pci_enable_msi_range (and __pci_enable_msix_range),
but they have been there for a while.
