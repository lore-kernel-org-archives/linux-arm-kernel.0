From: alan@linux.intel.com (Alan Cox)
Date: Tue, 13 Jan 2015 17:10:28 +0000
Subject: [PATCH] pcmcia: add missing include for new pci resource handler
In-Reply-To: <5425521.E2szj8uYq0@wuerfel>
References: <5425521.E2szj8uYq0@wuerfel>
Message-ID: <1421169028.6941.0.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-01-13 at 15:11 +0100, Arnd Bergmann wrote:
> The recently added rsrc_pci.c file calls pci_bus_alloc_resource without
> including the header file that declares it, and that sometimes causes
> a build warning on ARM:
> 
> drivers/pcmcia/rsrc_pci.c: In function 'find_io_region':
> drivers/pcmcia/rsrc_pci.c:40:2: error: implicit declaration of function 'pci_bus_alloc_resource' [-Werror=implicit-function-declaration]
> 
> This adds the missing include statement.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Fixes: 02b03846bb2be ("pcmcia: add a new resource manager for non ISA systems"

Acked-by: Alan Cox <alan@linux.intel.com>

I hadn't intended it to be sucked on ARM although I guess it ought to
work there just fine.

Alan
