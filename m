From: davem@davemloft.net (David Miller)
Date: Thu, 02 Nov 2017 20:33:47 +0900 (KST)
Subject: [PATCH] [net-next] net: seeq: fix timer conversion
In-Reply-To: <20171102111350.3380744-1-arnd@arndb.de>
References: <20171102111350.3380744-1-arnd@arndb.de>
Message-ID: <20171102.203347.1576440588782602203.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Thu,  2 Nov 2017 12:13:36 +0100

> One of the timer conversion patches evidently escaped build testing
> until I ran into in on ARM randconfig builds:
> 
> drivers/net/ethernet/seeq/ether3.c: In function 'ether3_ledoff':
> drivers/net/ethernet/seeq/ether3.c:175:40: error: 'priv' undeclared (first use in this function); did you mean 'pid'?
> drivers/net/ethernet/seeq/ether3.c:176:27: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
> 
> This fixes the two small typos that caused the problems.
> 
> Fixes: 6fd9c53f7186 ("net: seeq: Convert timers to use timer_setup()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thank you.
