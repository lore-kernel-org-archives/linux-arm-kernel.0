From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 1 Feb 2013 12:58:04 -0700
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <201302011745.29223.arnd@arndb.de>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201302011607.49205.arnd@arndb.de>
 <20130201162638.GT23505@n2100.arm.linux.org.uk>
 <201302011745.29223.arnd@arndb.de>
Message-ID: <20130201195804.GD19335@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 01, 2013 at 05:45:29PM +0000, Arnd Bergmann wrote:

> Yes, that was my point. I think in this case, the bug is in the new
> of_pci_process_ranges functions, which returns a 'struct resource'
> translated into IORESOURCE_MEM space, but with the type set
> to IORESOURCE_IO. This resource then gets passed to 
> pci_add_resource_offset().

A standard way to express the required address translation from CPU
physical address to IO bus address might help other people avoid this
trap??

Jason
