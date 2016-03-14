From: davem@davemloft.net (David Miller)
Date: Mon, 14 Mar 2016 13:06:45 -0400 (EDT)
Subject: [PATCH 3/3] net: mediatek: check device_reset return code
In-Reply-To: <1457964435-2945038-3-git-send-email-arnd@arndb.de>
References: <1457964435-2945038-1-git-send-email-arnd@arndb.de>
 <1457964435-2945038-3-git-send-email-arnd@arndb.de>
Message-ID: <20160314.130645.572195280477206552.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 14 Mar 2016 15:07:12 +0100

> The device_reset() function may fail, so we have to check
> its return value, e.g. to make deferred probing work correctly.
> gcc warns about it because of the warn_unused_result attribute:
> 
> drivers/net/ethernet/mediatek/mtk_eth_soc.c: In function 'mtk_probe':
> drivers/net/ethernet/mediatek/mtk_eth_soc.c:1679:2: error: ignoring return value of 'device_reset', declared with attribute warn_unused_result [-Werror=unused-result]
> 
> This adds the trivial error check to propagate the return value
> to the generic platform device probe code.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
