From: ryder.lee@mediatek.com (Ryder Lee)
Date: Wed, 23 Aug 2017 09:04:26 +0800
Subject: [PATCH v2 0/3] PCI: mediatek: Add MSI support for MT2712 and
 MT7622
In-Reply-To: <20170822213602.GK6948@bhelgaas-glaptop.roam.corp.google.com>
References: <1502715868-17651-1-git-send-email-honghui.zhang@mediatek.com>
 <20170822213602.GK6948@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <1503450266.11985.3.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-08-22 at 16:36 -0500, Bjorn Helgaas wrote:
> On Mon, Aug 14, 2017 at 09:04:25PM +0800, honghui.zhang at mediatek.com wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > 
> > MT2712 and MT7622's PCIe host controller support MSI, but only 32bit MSI
> > address are supportted. It connect to GIC with the same IRQ number of INTx
> > IRQ, so it shares the same IRQ with INTx IRQ.
> > 
> > This patchset add MSI support for MT2712 and MT7622.
> > Also do some code fixup and cleanups.
> > 
> > Change Since V1:
> >  - Add the first two patches into this patchset.
> >  - Using -ENODEV instead of PTR_ERR if msi_domain == NULL
> >  - Change the error logs with consistency of lower-case
> >  - Using has_msi instead of support_msi to make the parameter name a bit shorter
> > 
> > Honghui Zhang (3):
> >   PCI: mediatek: Fix return value in case of error
> >   PCI: mediatek: take use of bus->sysdata to get host private data
> >   PCI: mediatek: add msi support for MT2712 and MT7622
> > 
> >  drivers/pci/host/pcie-mediatek.c | 157 +++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 151 insertions(+), 6 deletions(-)
> 
> Just waiting for an ack from Ryder...

For whole series:

Acked-by: Ryder Lee <ryder.lee@mediatek.com>
