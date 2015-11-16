From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 16 Nov 2015 09:22:20 +0530
Subject: [PATCH] dma: at_hdmac: use %pad format string for dma_addr_t
In-Reply-To: <3938068.0vDFThTK2h@wuerfel>
References: <3938068.0vDFThTK2h@wuerfel>
Message-ID: <20151116035219.GB25173@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2015 at 03:18:22PM +0100, Arnd Bergmann wrote:
> dma_addr_t may be defined as 32 or 64 bit depending on configuration,
> so it cannot be printed using the normal format strings, as
> gcc correctly warns:
> 
> drivers/dma/at_hdmac.c: In function 'atc_prep_dma_interleaved':
> drivers/dma/at_hdmac.c:731:28: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'dma_addr_t {aka long long unsigned int}' [-Wformat=]
> 
> This changes the format strings to use the special "%pad" format
> string that prints a dma_addr_t, and changes the arguments so we
> pass the address by reference as required.
> 

Applied, thanks

-- 
~Vinod
