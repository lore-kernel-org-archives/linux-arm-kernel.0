From: nipun.gupta@nxp.com (Nipun Gupta)
Date: Mon, 30 Apr 2018 03:27:16 +0000
Subject: [PATCH 2/6 v3] iommu: of: make of_pci_map_rid() available for
 other devices too
In-Reply-To: <20180427171537.lvzygghnuolk6cnh@rob-hp-laptop>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1524824826-29473-3-git-send-email-nipun.gupta@nxp.com>
 <20180427171537.lvzygghnuolk6cnh@rob-hp-laptop>
Message-ID: <DB6PR0401MB2424DEAB9AE3C3A78ED348C5E6820@DB6PR0401MB2424.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Friday, April 27, 2018 10:46 PM
> To: Nipun Gupta <nipun.gupta@nxp.com>
> Cc: robin.murphy at arm.com; will.deacon at arm.com; mark.rutland at arm.com;
> catalin.marinas at arm.com; hch at lst.de; gregkh at linuxfoundation.org;
> joro at 8bytes.org; m.szyprowski at samsung.com; shawnguo at kernel.org;
> frowand.list at gmail.com; bhelgaas at google.com; iommu at lists.linux-
> foundation.org; linux-kernel at vger.kernel.org; devicetree at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linuxppc-dev at lists.ozlabs.org; linux-
> pci at vger.kernel.org; Bharat Bhushan <bharat.bhushan@nxp.com>;
> stuyoder at gmail.com; Laurentiu Tudor <laurentiu.tudor@nxp.com>; Leo Li
> <leoyang.li@nxp.com>
> Subject: Re: [PATCH 2/6 v3] iommu: of: make of_pci_map_rid() available for
> other devices too
> 
> On Fri, Apr 27, 2018 at 03:57:02PM +0530, Nipun Gupta wrote:
> > iommu-map property is also used by devices with fsl-mc. This
> > patch moves the of_pci_map_rid to generic location, so that it
> > can be used by other busses too.
> >
> > 'of_pci_map_rid' is renamed here to 'of_map_rid' and there is no
> > functional change done in the API.
> >
> > Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> > ---
> >  drivers/iommu/of_iommu.c   |   6 +--
> >  drivers/of/address.c       | 102
> +++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/of/irq.c           |   7 ++--
> >  drivers/pci/of.c           | 101 --------------------------------------------
> >  include/linux/of_address.h |  11 +++++
> >  include/linux/of_pci.h     |  10 -----
> >  6 files changed, 120 insertions(+), 117 deletions(-)
> 
> of/address.c isn't really the best fit either, though I don't have a
> better suggestion.
> 
> I'm guessing this breaks on Sparc which doesn't build of/address.c.
> I guess move it to base.c and of.h if that is the case.

Sure, that makes sense. Thank you for the suggestion !!
I'll spin off new version with this change.

Regards,
Nipun

> 
> Rob
