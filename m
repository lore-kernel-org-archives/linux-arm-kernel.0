From: davem@davemloft.net (David Miller)
Date: Fri, 20 Jan 2017 11:46:00 -0500 (EST)
Subject: [PATCH 3/3] bcm63xx_enet: avoid uninitialized variable warning
In-Reply-To: <20170118145306.1004008-3-arnd@arndb.de>
References: <20170118145306.1004008-1-arnd@arndb.de>
 <20170118145306.1004008-3-arnd@arndb.de>
Message-ID: <20170120.114600.1285813871724893800.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 18 Jan 2017 15:52:53 +0100

> gcc-7 and probably earlier versions get confused by this function
> and print a harmless warning:
> 
> drivers/net/ethernet/broadcom/bcm63xx_enet.c: In function 'bcm_enet_open':
> drivers/net/ethernet/broadcom/bcm63xx_enet.c:1130:3: error: 'phydev' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> This adds an initialization for the 'phydev' variable when it is unused
> and changes the check to test for that NULL pointer to make it clear
> that we always pass a valid pointer here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Also applied, thanks.
