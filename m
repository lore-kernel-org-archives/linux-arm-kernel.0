From: jcm@jonmasters.org (Jon Masters)
Date: Tue, 25 Apr 2017 02:40:57 -0400
Subject: [PATCH v4 00/21] PCI: fix config space memory mappings
In-Reply-To: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
References: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
Message-ID: <2e24e205-d761-9172-9463-4a53e1a0de4d@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2017 12:48 PM, Lorenzo Pieralisi wrote:

> On some platforms (ie ARM/ARM64) ioremap fails to comply with the PCI
> configuration non-posted write transactions requirement, because it
> provides a memory mapping that issues "bufferable" or, in PCI terms
> "posted" write transactions. Likewise, the current pci_remap_iospace()
> implementation maps the physical address range that the PCI translates
> to I/O space cycles to virtual address space through pgprot_device()
> attributes that on eg ARM64 provides a memory mapping issuing
> posted writes transactions, which is not PCI specifications compliant.

Side note that I've pinged all of the ARM server vendors and asked them
to verify this patch series on their platforms.

Jon.
