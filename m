From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 27 Oct 2014 15:44:46 +0000
Subject: [PATCH RFC 2/2] drivers: pci: convert generic host controller to
 DT resource parsing API
In-Reply-To: <20141027120335.GQ8768@arm.com>
References: <1414077787-20633-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1414077787-20633-2-git-send-email-lorenzo.pieralisi@arm.com>
 <20141027120335.GQ8768@arm.com>
Message-ID: <20141027154446.GA773@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 12:03:35PM +0000, Will Deacon wrote:
> On Thu, Oct 23, 2014 at 04:23:07PM +0100, Lorenzo Pieralisi wrote:
> > In order to consolidate DT configuration for PCI host controllers in the
> > kernel, a new API (ie of_pci_get_host_bridge_resources()) was developed
> > to allow parsing and assigning IO/BUS/MEM resources from DT, removing
> > duplicated code present in the majority of pci host driver implementations.
> > 
> > This patch converts the existing PCI generic host controller driver to
> > the new API. Most of the code parsing ranges and creating resources is
> > now delegated to of_pci_get_host_bridge_resources() API.
> > 
> > The PCI host controller code carries out resources filtering on the
> > resulting resource list and maps IO space by using the newly introduced
> > pci_ioremap_iospace() API.
> > 
> > New code supports only one IO resource per generic host controller, which
> > should cater for all existing host controller configurations.
> > 
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> >  drivers/pci/host/pci-host-generic.c | 120 ++++++++----------------------------
> >  1 file changed, 27 insertions(+), 93 deletions(-)
> 
> Looks fine to me -- I assume you tested this under a 32-bit kernel?

Yes, through kvmtools, 32-bit guest on 32/64 bits hosts. I will keep on
testing it before asking to merge it in -next. I would be grateful if the
parsing logic could be tested on arm64 too (Suravee, did you give them
a try ?) and collect the resulting tested-by.

>   Acked-by: Will Deacon <will.deacon@arm.com>

Thank you !
Lorenzo
