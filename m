From: slash.tmp@free.fr (Mason)
Date: Tue, 21 Mar 2017 11:15:16 +0100
Subject: [RFC PATCH v0.001] PCI: Add support for tango PCIe controller
In-Reply-To: <ab110ce2-8678-9b34-6bd1-6cfaaa7fea04@free.fr>
References: <ab110ce2-8678-9b34-6bd1-6cfaaa7fea04@free.fr>
Message-ID: <f13c385d-dcc9-dacd-2b2c-ca098228f4f4@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ Adding iommu ML ]

On 17/03/2017 17:11, Mason wrote:

> + * QUIRK #5
> + * Only transfers within the BAR are forwarded to the host.
> + * By default, the DMA framework expects that
> + * PCI address 0x8000_0000 -> CPU address 0x8000_0000
> + * which is where DRAM0 is mapped.

I have an additional question on this topic.

In a typical system, PCI bus masters are able to access all of RAM,
unless there is some kind of IOMMU, right?

I suppose one may consider the above limitation ("Only transfers
within the BAR are forwarded to the host") as some form of weird
IOMMU? (There is, in fact, some remapping logic in the controller
setup which I haven't discussed so far.)

Since this SoC is used for TV, the media cartels mandate some way
to limit where PCI bus masters can peek/poke in RAM.

Regards.
