From: nipun.gupta@nxp.com (Nipun Gupta)
Date: Fri, 9 Mar 2018 18:29:41 +0000
Subject: [PATCH 5/6] dma-mapping: support fsl-mc bus
In-Reply-To: <20180308074115.GB15748@lst.de>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1520260166-29387-6-git-send-email-nipun.gupta@nxp.com>
 <20180305150814.GA15918@lst.de>
 <7b4f9972-6aaa-fc9d-3854-d48b19a8051c@arm.com>
 <20180305183938.GB20086@lst.de>
 <1729ae21-d08c-b413-51a3-f22c394b388d@arm.com>
 <HE1PR0401MB24251E99564CAA526F719ECCE6D90@HE1PR0401MB2425.eurprd04.prod.outlook.com>
 <20180308074115.GB15748@lst.de>
Message-ID: <HE1PR0401MB2425871215B13AD0EFDCA5C3E6DE0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch at lst.de]
> Sent: Thursday, March 08, 2018 13:11
> 
> On Tue, Mar 06, 2018 at 04:41:56AM +0000, Nipun Gupta wrote:
> > Sorry for asking a trivial question - looking into dma_configure() I see that
> > PCI is used in the start and the end of the API.
> > In the end part pci_put_host_bridge_device() is called.
> > So are two bus callbacks something like 'dma_config_start' &
> 'dma_config_end'
> > will be required where the former one will return "dma_dev"?
> 
> I'd just use dma_configure as the callback.

This would be a decent stuff.

> 
> Currently the of_dma_configure and acpi_dma_configure are only used
> for PCI anyway, as no one else sets a non-NULL dma dev.

My understanding is that even the platform bus uses the of_dma_configure
and probably acpi_dma_configure too. So platform bus may also need the
callback implemented. Please correct me if my understanding is wrong.

I will submit the patch with 'dma_configure' callback implemented for
the busses shortly.

> For fsl-mc I suspect only of_dma_configure is relevanet, so just call that directly.
> If at some point we get enough busses with either OF or ACPI we could
> create a helper called from ->dma_configure for that.

Totally agree with this.

Thanks,
Nipun
