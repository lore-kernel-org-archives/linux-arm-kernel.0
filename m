From: rientjes@google.com (David Rientjes)
Date: Mon, 2 Feb 2015 09:51:30 -0800 (PST)
Subject: [PATCH] mm: export "high_memory" symbol on !MMU
In-Reply-To: <2715923.qFZi90ffep@wuerfel>
References: <2715923.qFZi90ffep@wuerfel>
Message-ID: <alpine.DEB.2.10.1502020951180.5117@chino.kir.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Jan 2015, Arnd Bergmann wrote:

> The symbol 'high_memory' is provided on both MMU- and NOMMU-kernels,
> but only one of them is exported, which leads to module build errors
> in drivers that work fine built-in:
> 
> ERROR: "high_memory" [drivers/net/virtio_net.ko] undefined!
> ERROR: "high_memory" [drivers/net/ppp/ppp_mppe.ko] undefined!
> ERROR: "high_memory" [drivers/mtd/nand/nand.ko] undefined!
> ERROR: "high_memory" [crypto/tcrypt.ko] undefined!
> ERROR: "high_memory" [crypto/cts.ko] undefined!
> 
> This exports the symbol to get these to work on NOMMU as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: David Rientjes <rientjes@google.com>
