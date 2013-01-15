From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Jan 2013 12:44:12 +0000
Subject: [PATCH 10/14] PCI: tegra: Move PCIe driver to drivers/pci/host
In-Reply-To: <20130115120855.GA5637@avionic-0098.adnet.avionic-design.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <20130114095706.GA23467@arm.com>
 <20130115120855.GA5637@avionic-0098.adnet.avionic-design.de>
Message-ID: <201301151244.12767.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 January 2013, Thierry Reding wrote:
> I'm not sure I follow you're reasoning here. Is it possible to use MSIs
> without PCI? If not then I think there's little sense in keeping the
> implementations separate.

Conceptually, you can use MSI for any device, but the Linux interfaces
for MSI are tied to PCI. If you use an MSI controller for a non-PCI
device, it would probably just appear as a regular interrupt controller.

> Furthermore, if MSI controller and PCI host bridge are separate entities
> how do you look up the MSI controller given a PCI device?

The host bridge can contain a pointer ot the MSI controller. You can
have multiple host bridges sharing a single MSI controller or you
can have separate ones for each host.

	Arnd
