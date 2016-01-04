From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 4 Jan 2016 14:21:42 +0100
Subject: [PATCH] PCI: provide of_pci_get_host_bridge_resources helper
In-Reply-To: <8759253.sZisGJ6Km3@wuerfel>
References: <8759253.sZisGJ6Km3@wuerfel>
Message-ID: <20160104132142.GA11689@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 04:02:41PM +0100, Arnd Bergmann wrote:
> The pcie-rcar driver can be built for any ARM platform (for COMPILE_TEST)
> including those without CONFIG_OF enabled, and that results in a compile-time
> error:
> 
> drivers/pci/host/pcie-rcar.c: In function 'rcar_pcie_parse_request_of_pci_ranges':
> drivers/pci/host/pcie-rcar.c:939:8: error: implicit declaration of function 'of_pci_get_host_bridge_resources' [-Werror=implicit-function-declaration]
>   err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pci->resources, &iobase);
> 
> In order to allow compile-testing on all platforms, this adds a
> of_pci_get_host_bridge_resources() helper stub function that gets
> used when CONFIG_OF_ADDRESS is disabled. This mirrors what we do for
> other OF-specific functions.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 5d2917d469fa ("PCI: rcar: Convert to DT resource parsing API")

Makes sense :)

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160104/ec54467d/attachment.sig>
