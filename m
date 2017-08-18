From: mpe@ellerman.id.au (Michael Ellerman)
Date: Fri, 18 Aug 2017 14:32:36 +1000
Subject: [PATCH] PCI: Allow PCI express root ports to find themselves
In-Reply-To: <20170817110614.11454-1-thierry.reding@gmail.com>
References: <1502936730-7368-1-git-send-email-dingtianhong@huawei.com>
 <20170817110614.11454-1-thierry.reding@gmail.com>
Message-ID: <87bmndqyvv.fsf@concordia.ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry Reding <thierry.reding@gmail.com> writes:

> From: Thierry Reding <treding@nvidia.com>
>
> If the pci_find_pcie_root_port() function is called on a root port
> itself, return the root port rather than NULL.
>
> This effectively reverts commit 0e405232871d6 ("PCI: fix oops when
> try to find Root Port for a PCI device") which added an extra check
> that would now be redundant.
>
> Fixes: a99b646afa8a ("PCI: Disable PCIe Relaxed Ordering if unsupported")
> Fixes: c56d4450eb68 ("PCI: Turn off Request Attributes to avoid Chelsio T5 Completion erratum")
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> This applies on top of and was tested on next-20170817.
>
> Michael, it'd be great if you could test this one again to clarify
> whether or not the fix that's already in Linus' tree is still needed, or
> whether it's indeed obsoleted by this patch.

This works fine for me, applied on top of Linus' tree (d33a2a914319).

cheers
