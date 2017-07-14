From: davem@davemloft.net (David Miller)
Date: Fri, 14 Jul 2017 09:03:55 -0700 (PDT)
Subject: [PATCH 11/22] net: thunder_bgx: avoid format string overflow
 warning
In-Reply-To: <20170714120720.906842-12-arnd@arndb.de>
References: <20170714120720.906842-1-arnd@arndb.de>
 <20170714120720.906842-12-arnd@arndb.de>
Message-ID: <20170714.090355.1299368178510322895.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 14 Jul 2017 14:07:03 +0200

> gcc warns that the temporary buffer might be too small here:
> 
> drivers/net/ethernet/cavium/thunder/thunder_bgx.c: In function 'bgx_probe':
> drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1020:16: error: '%d' directive writing between 1 and 10 bytes into a region of size between 9 and 11 [-Werror=format-overflow=]
> sprintf(str, "BGX%d LMAC%d mode", bgx->bgx_id, lmacid);
>              ^~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1020:16: note: directive argument in the range [0, 2147483647]
> drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1020:3: note: 'sprintf' output between 16 and 27 bytes into a destination of size 20
> 
> This probably can't happen, but it can't hurt to make it long
> enough for the theoretical limit.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
