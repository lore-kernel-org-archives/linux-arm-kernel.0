From: andrew.murray@arm.com (Andrew Murray)
Date: Mon, 25 Mar 2013 10:21:06 +0000
Subject: [PATCH 1/6] of/pci: Provide support for parsing PCI DT ranges
 property
In-Reply-To: <20130323143704.5da5d20c@skate>
References: <00c001ce277b$92b26ab0$b8174010$%han@samsung.com>
 <20130323104156.GL4977@n2100.arm.linux.org.uk>
 <20130323143704.5da5d20c@skate>
Message-ID: <20130325102106.GA20770@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 23, 2013 at 01:37:04PM +0000, Thomas Petazzoni wrote:
> 
> On Sat, 23 Mar 2013 10:41:56 +0000, Russell King - ARM Linux wrote:
> 
> > Please look at how IORESOURCE_* stuff is defined:
> > #define IORESOURCE_TYPE_BITS    0x00001f00      /* Resource type */
> > #define IORESOURCE_IO           0x00000100      /* PCI/ISA I/O ports */
> > #define IORESOURCE_MEM          0x00000200
> > #define IORESOURCE_REG          0x00000300      /* Register offsets */
> > #define IORESOURCE_IRQ          0x00000400
> > #define IORESOURCE_DMA          0x00000800
> > #define IORESOURCE_BUS          0x00001000
> > 
> > Notice that it's not an array of bits.
> > 
> > So this should be:
> > 		if ((iter.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_IO) {
> 
> What I've done for the Marvell PCIe driver is:
> 
> +	for_each_of_pci_range(&iter, np) {
> +		unsigned long restype = iter.flags & IORESOURCE_TYPE_BITS;
> +		if (restype == IORESOURCE_IO) {
> [...]
> +		if (restype == IORESOURCE_MEM) {
> [...]

OK I'll update this patch and also include Thierry's suggestions.

Andrew Murray
