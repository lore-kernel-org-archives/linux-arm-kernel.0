From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 23 Oct 2014 10:52:06 -0600
Subject: [RFC 2/4] PCI: generic: Add support for ARM64 and MSI(x)
In-Reply-To: <20141023112731.GA5823@e102568-lin.cambridge.arm.com>
References: <1411937610-22125-1-git-send-email-suravee.suthikulpanit@amd.com>
 <3256560.C0cZnIlnAv@wuerfel>
 <20141022155914.GB25939@e102568-lin.cambridge.arm.com>
 <2148776.X8NPqiYA6S@wuerfel>
 <20141023091309.GF25302@e106497-lin.cambridge.arm.com>
 <20141023112731.GA5823@e102568-lin.cambridge.arm.com>
Message-ID: <20141023165206.GB13465@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 23, 2014 at 12:27:31PM +0100, Lorenzo Pieralisi wrote:

> I think that by removing that, we could switch to CONFIG_PCI_DOMAINS_GENERIC
> on ARM32. I will remove the dependency in drivers/pci/host/pci-mvebu.c
> introduced by commit 2613ba48. pci_sys_data.domain is always 0 in that
> driver so its usefulness is doubtful, comments welcome, copied Jason in
> if he has comments.

pcie-mvebu is like all the other new drivers, each top level DT node
that introduces the interface should have a unique domain number. It
would be very strange (and currently unsupported by the driver) to
ever have more than 1 mvebu top level node in any DT.

Jason
