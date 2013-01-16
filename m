From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Jan 2013 14:00:26 +0000
Subject: [PATCH 10/14] PCI: tegra: Move PCIe driver to drivers/pci/host
In-Reply-To: <20130115211441.GA13139@avionic-0098.adnet.avionic-design.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <20130115154038.GA11241@arm.com>
 <20130115211441.GA13139@avionic-0098.adnet.avionic-design.de>
Message-ID: <201301161400.26587.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 January 2013, Thierry Reding wrote:
> Is there actually hardware that supports this? I assumed that the MSI
> controller would have to be tightly coupled to the PCI host bridge in
> order to raise an interrupt when an MSI is received via PCI.

No, as long as it's guaranteed that the MSI notification won't arrive
at the CPU before any inbound DMA data before it, the MSI controller
can be anywhere. Typically, the MSI controller is actually closer to
the CPU core than to the PCI bridge. On X86, I believe the MSI address
is on normally on the the "local APIC" on each CPU.

	Arnd
