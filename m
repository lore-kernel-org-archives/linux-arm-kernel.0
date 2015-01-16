From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Jan 2015 11:12:43 +0100
Subject: [PATCH 00/28] Refine PCI scan interfaces and make generic pci
 host bridge
In-Reply-To: <1421372666-12288-1-git-send-email-wangyijing@huawei.com>
References: <1421372666-12288-1-git-send-email-wangyijing@huawei.com>
Message-ID: <3853153.SqP6BVNhms@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 January 2015 09:43:58 Yijing Wang wrote:
> This series is based on Bjorn's pci-next branch.

I think this is a very nice series, hope we can get this into 3.20.

I've replied with a few specific comments, but I see no show-stoppers
and I've already retracted a few comments after seeing the bigger
picture.

> After applied this series, we have following scan interfaces:
> 
> 1. pci_scan_bus_legacy() 
>    parent = NULL, default io/mem/bus resources.
>    for legacy pci scan
> 
> 2. pci_scan_root_bus()
>    for callers provide its own parent and io/mem/bus resources
>    but no platform specific pci_host_bridge operations
> 
> 3. pci_scan_root_bridge()
>    for callers provide its own parent and io/mem/bus resources
>    and pci_host_bridge_ops.

I still think we will need a split interface for drivers to use
that want to call pci_create_host_bridge() manually, but that can
come later as we try to migrate the arm32 host bridge drivers to
a generic interface away from pci_common_init_dev().

Another follow-up would be to move more of the pcibios_*() functions
into pci_host_bridge_ops.

	Arnd
