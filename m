From: davem@davemloft.net (David Miller)
Date: Mon, 14 Mar 2016 13:06:33 -0400 (EDT)
Subject: [PATCH 1/3] net: mediatek: use dma_addr_t correctly
In-Reply-To: <1457964435-2945038-1-git-send-email-arnd@arndb.de>
References: <1457964435-2945038-1-git-send-email-arnd@arndb.de>
Message-ID: <20160314.130633.1932883457156537338.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 14 Mar 2016 15:07:10 +0100

> dma_alloc_coherent() expects a dma_addr_t pointer as its argument,
> not an 'unsigned int', and gcc correctly warns about broken
> code in the mtk_init_fq_dma function:
> 
> drivers/net/ethernet/mediatek/mtk_eth_soc.c: In function 'mtk_init_fq_dma':
> drivers/net/ethernet/mediatek/mtk_eth_soc.c:463:13: error: passing argument 3 of 'dma_alloc_coherent' from incompatible pointer type [-Werror=incompatible-pointer-types]
> 
> This changes the type of the local variable to dma_addr_t.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
