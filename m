From: davem@davemloft.net (David Miller)
Date: Tue, 18 Oct 2016 14:21:04 -0400 (EDT)
Subject: [PATCH 20/28] net: bcm63xx: avoid referencing uninitialized
 variable
In-Reply-To: <20161017221650.1902729-1-arnd@arndb.de>
References: <20161017220342.1627073-1-arnd@arndb.de>
 <20161017221650.1902729-1-arnd@arndb.de>
Message-ID: <20161018.142104.1792947498376488428.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 18 Oct 2016 00:16:08 +0200

> gcc found a reference to an uninitialized variable in the error handling
> of bcm_enet_open, introduced by a recent cleanup:
> 
> drivers/net/ethernet/broadcom/bcm63xx_enet.c: In function 'bcm_enet_open'
> drivers/net/ethernet/broadcom/bcm63xx_enet.c:1129:2: warning: 'phydev' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> This makes the use of that variable conditional, so we only reference it
> here after it has been used before. Unlike my normal patches, I have not
> build-tested this one, as I don't currently have mips test in my
> randconfig setup.
> 
> Fixes: 625eb8667d6f ("net: ethernet: broadcom: bcm63xx: use phydev from struct net_device")
> Cc: Philippe Reynes <tremyfr@gmail.com>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
