From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 16 Nov 2015 09:22:04 +0530
Subject: [PATCH] dma: at_xdmac: use %pad format string for dma_addr_t
In-Reply-To: <3796793.2XNherj1df@wuerfel>
References: <3796793.2XNherj1df@wuerfel>
Message-ID: <20151116035204.GA25173@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2015 at 03:16:53PM +0100, Arnd Bergmann wrote:
> dma_addr_t may be defined as 32 or 64 bit depending on configuration,
> so it cannot be printed using the normal format strings, as
> gcc correctly warns:
> 
> drivers/dma/at_xdmac.c: In function 'at_xdmac_interleaved_queue_desc':
> drivers/dma/at_xdmac.c:922:51: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'dma_addr_t {aka long long unsigned int}' [-Wformat=]
> 
> This changes the format strings to use the special "%pad" format
> string that prints a dma_addr_t, and changes the arguments so we
> pass the address by reference as required.

Applied, thanks

-- 
~Vinod
