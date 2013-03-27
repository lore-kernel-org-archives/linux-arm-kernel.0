From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 27 Mar 2013 14:04:18 +0100
Subject: [PATCH v3] of/pci: Provide support for parsing PCI DT ranges
 property
In-Reply-To: <20130326162022.GA25625@arm.com>
References: <20130326162022.GA25625@arm.com>
Message-ID: <20130327130418.GA10480@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 26, 2013 at 04:20:23PM +0000, Andrew Murray wrote:
> This patch factors out common implementation patterns to reduce overall kernel
> code and provide a means for host bridge drivers to directly obtain struct
> resources from the DT's ranges property without relying on architecture specific
> DT handling. This will make it easier to write archiecture independent host bridge
> drivers and mitigate against further duplication of DT parsing code.
> 
> This patch can be used in the following way:
> 
> 	struct of_pci_range_parser parser;
> 	struct of_pci_range range;
> 
> 	if (of_pci_range_parser(&parser, np))
> 		; //no ranges property
> 
> 	for_each_of_pci_range(&parser, &range) {
> 
> 		/*
> 			directly access properties of the address range, e.g.:
> 			range.pci_space, range.pci_addr, range.cpu_addr,
> 			range.size, range.flags
> 
> 			alternatively obtain a struct resource, e.g.:
> 			struct resource res;
> 			of_pci_range_to_resource(&range, np, &res);
> 		*/
> 	}
> 
> Additionally the implementation takes care of adjacent ranges and merges them
> into a single range (as was the case with powerpc and microblaze).
> 
> The modifications to microblaze, mips and powerpc have not been tested.
> 
> Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Tested-by: Thierry Reding <thierry.reding@avionic-design.de>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130327/53861471/attachment.sig>
