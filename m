From: felipe.balbi@linux.intel.com (Felipe Balbi)
Date: Thu, 02 Nov 2017 17:38:20 +0200
Subject: [PATCH] usb: mtu3: fix dma_addr_t printk output again
In-Reply-To: <20171102143027.775184-1-arnd@arndb.de>
References: <20171102143027.775184-1-arnd@arndb.de>
Message-ID: <87y3no8zdf.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Arnd Bergmann <arnd@arndb.de> writes:
> The support for 36-bit addresses originally came with an incorrect
> printk format for dma addresses. Felipe changed the format string it
> while applying, but the result was still incorrect, since we now have
> to pass a pointer to the address instead of the integer value:
>
> drivers/usb/mtu3/mtu3_qmu.c: In function 'mtu3_prepare_tx_gpd':
> drivers/usb/mtu3/mtu3_qmu.c:261:25: error: format '%p' expects argument of type 'void *', but argument 7 has type 'dma_addr_t {aka unsigned int}' [-Werror=format=]
> drivers/usb/mtu3/mtu3_qmu.c: In function 'mtu3_prepare_rx_gpd':
> drivers/usb/mtu3/mtu3_qmu.c:300:25: error: format '%p' expects argument of type 'void *', but argument 7 has type 'dma_addr_t {aka unsigned int}' [-Werror=format=]
>
> This fixes the printk argument accordingly.
>
> Fixes: 1a46dfea0841 ("usb: mtu3: support 36-bit DMA address")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

oh, so it wants a pointer afterall :-)

sorry.

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

-- 
balbi
