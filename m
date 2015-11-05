From: davem@davemloft.net (David Miller)
Date: Thu, 05 Nov 2015 00:00:41 -0500 (EST)
Subject: [PATCH] bnxt_en: add VXLAN dependency
In-Reply-To: <10667823.xAtO4QOJMM@wuerfel>
References: <10667823.xAtO4QOJMM@wuerfel>
Message-ID: <20151105.000041.1943232712662050944.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 04 Nov 2015 16:00:32 +0100

> VXLAN may be a loadable module, and this driver cannot be built-in
> in that case, or we get a link error:
> 
> drivers/built-in.o: In function `__bnxt_open_nic':
> drivers/net/ethernet/broadcom/bnxt/bnxt.c:4581: undefined reference to `vxlan_get_rx_port'
> 
> This adds a Kconfig dependency that ensures that either VXLAN is
> disabled (which the driver handles correctly), or we depend on
> VXLAN itself and disallow built-in compilation when VXLAN is
> a module.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")

Applied, thanks.
