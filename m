From: davem@davemloft.net (David Miller)
Date: Fri, 15 Mar 2013 08:55:10 -0400 (EDT)
Subject: [PATCH 0/4] mv643xx_eth: use mvmdio MDIO bus driver
In-Reply-To: <20130315.085321.1047694772636447477.davem@davemloft.net>
References: <1359473048-26551-1-git-send-email-florian@openwrt.org>
 <1363284515-9865-1-git-send-email-florian@openwrt.org>
 <20130315.085321.1047694772636447477.davem@davemloft.net>
Message-ID: <20130315.085510.974056254781971889.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Miller <davem@davemloft.net>
Date: Fri, 15 Mar 2013 08:53:21 -0400 (EDT)

> From: Florian Fainelli <florian@openwrt.org>
> Date: Thu, 14 Mar 2013 19:08:31 +0100
> 
>> This patch converts the mv643xx_eth driver to use the mvmdio MDIO bus driver
>> instead of rolling its own implementation. As a result, all users of this
>> mv643xx_eth driver are converted to register an "orion-mdio" platform_device.
>> The mvmdio driver is also updated to support an interrupt line which reports
>> SMI error/completion, and to allow traditionnal platform device registration
>> instead of just device tree.
>> 
>> David, I think it makes sense for you to merge all of this, since we do
>> not want the architecture files to be desynchronized from the mv643xx_eth to
>> avoid runtime breakage. The potential for merge conflicts should be very small.
> 
> All applied to net-next, thanks.

Actually, reverted.  Please send me code which actually compiles:

drivers/net/ethernet/marvell/mvmdio.c: In function ?orion_mdio_wait_ready?:
drivers/net/ethernet/marvell/mvmdio.c:70:28: error: ?NO_IRQ? undeclared (first use in this function)
drivers/net/ethernet/marvell/mvmdio.c:70:28: note: each undeclared identifier is reported only once for each function it appears in
drivers/net/ethernet/marvell/mvmdio.c: In function ?orion_mdio_probe?:
drivers/net/ethernet/marvell/mvmdio.c:242:24: error: ?NO_IRQ? undeclared (first use in this function)
make[4]: *** [drivers/net/ethernet/marvell/mvmdio.o] Error 1

And don't use Kconfig dependencies to work around this, fix it properly.
