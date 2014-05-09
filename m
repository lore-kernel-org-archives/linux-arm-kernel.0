From: davem@davemloft.net (David Miller)
Date: Fri, 09 May 2014 16:39:33 -0400 (EDT)
Subject: [PATCH] mdio_bus: fix devm_mdiobus_alloc_size export
In-Reply-To: <1399560433-1402630-2-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560433-1402630-2-git-send-email-arnd@arndb.de>
Message-ID: <20140509.163933.1063955800318301161.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Thu,  8 May 2014 16:46:52 +0200

> commit 6d48f44b7b2 "mdio_bus: implement devm_mdiobus_alloc/devm_mdiobus_free"
> introduced a new function devm_mdiobus_alloc_size() but added an export
> for a different function devm_mdiobus_alloc(), which was obviously
> a simple mistake that leads to  build error whenever this function is
> used from a loadable module:
> 
> ERROR: "devm_mdiobus_alloc_size" [drivers/net/ethernet/ti/davinci_mdio.ko] undefined!
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to net-next, thanks Arnd.
