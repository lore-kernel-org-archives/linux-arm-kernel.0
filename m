From: rdunlap@infradead.org (Randy Dunlap)
Date: Thu, 12 Sep 2013 10:05:32 -0700
Subject: [PATCH] dma: use %pa to print dma_addr_t
In-Reply-To: <1378960710-15648-1-git-send-email-olof@lixom.net>
References: <1378960710-15648-1-git-send-email-olof@lixom.net>
Message-ID: <5231F45C.3020500@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/13 21:38, Olof Johansson wrote:
> This resolves some warnings seen when building with CONFIG_ARM_LPAE=y, since
> dma_addr_t might then be 64-bit:
> 
>   drivers/dma/imx-sdma.c:1092:3: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t' [-Wformat=]
>   drivers/dma/imx-sdma.c:1166:3: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t' [-Wformat=]
>   drivers/dma/imx-dma.c:579:3: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t' [-Wformat=]
>   drivers/dma/imx-dma.c:579:3: warning: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'dma_addr_t' [-Wformat=]
>   drivers/dma/imx-dma.c:593:4: warning: format '%x' expects argument of type 'unsigned int', but argument 9 has type 'dma_addr_t' [-Wformat=]
>   drivers/dma/imx-dma.c:603:4: warning: format '%x' expects argument of type 'unsigned int', but argument 9 has type 'dma_addr_t' [-Wformat=]
>   drivers/dma/imx-dma.c:930:2: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t' [-Wformat=]
>   drivers/dma/imx-dma.c:930:2: warning: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'dma_addr_t' [-Wformat=]
>   drivers/dma/imx-dma.c:960:2: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t' [-Wformat=]
>   drivers/dma/imx-dma.c:960:2: warning: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'dma_addr_t' [-Wformat=]
>   drivers/dma/ipu/ipu_idmac.c:1235:2: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'dma_addr_t' [-Wformat=]


I've been tempted to make similar patches, but CONFIG_PHYS_ADDR_T_64BIT
and CONFIG_ARCH_DMA_ADDR_T_64BIT are independent AFAICT,
and %pa is for physical addresses, not necessarily DMA addresses.

Am I confused?


-- 
~Randy
