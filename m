From: davem@davemloft.net (David Miller)
Date: Fri, 11 Dec 2015 19:35:03 -0500 (EST)
Subject: [PATCH 2/2] netcp: add more __le32 annotations
In-Reply-To: <6435706.peaM34LhnV@wuerfel>
References: <1578620.t1ANcREMZ8@wuerfel>
	<6435706.peaM34LhnV@wuerfel>
Message-ID: <20151211.193503.312733505035879098.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 08 Dec 2015 16:32:59 +0100

> The handling of epib and psdata remains a bit unclear in the driver,
> as we access the same fields both as CPU-endian and through DMA
> from the device.
> 
> Sparse warns about this:
> ti/netcp_core.c:1147:21: warning: incorrect type in assignment (different base types)
> ti/netcp_core.c:1147:21:    expected unsigned int [usertype] *[assigned] epib
> ti/netcp_core.c:1147:21:    got restricted __le32 *<noident>
> 
> This uses __le32 types in a few places and uses __force where the code
> looks fishy. The previous patch should really have produced the correct
> behavior, but this second patch is needed to shut up the warnings about
> it. Ideally it would be slightly rewritten to not need those casts,
> but I don't dare do that without access to the hardware for proper
> testing.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to net-next.
