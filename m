From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Sep 2015 18:59:40 +0100
Subject: [PATCH v2 2/5] PCI: generic: Only fixup irqs for bus we are
 creating.
In-Reply-To: <1442527332-1174-3-git-send-email-ddaney.cavm@gmail.com>
References: <1442527332-1174-1-git-send-email-ddaney.cavm@gmail.com>
 <1442527332-1174-3-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20150923175940.GU7356@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2015 at 11:02:09PM +0100, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> If we create multiple buses with pci-host-generic, or there are buses
> created by other drivers, we don't want to call pci_fixup_irqs() which
> operates on all devices, not just the devices on the bus being added.
> The consequence is that either the fixups are done more than once, or
> in some cases incorrect fixups could be applied.
> 
> Call pci_bus_fixup_irqs() instead of pci_fixup_irqs().
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
> Changes from v1: Moved most of the code to pci_bus_fixup_irqs(),
> making this patch very simple.

Acked-by: Will Deacon <will.deacon@arm.com>

Will
