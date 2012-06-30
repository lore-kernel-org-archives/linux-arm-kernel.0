From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 30 Jun 2012 13:02:37 +0100
Subject: [PATCH 1/3] mfd: support 88pm80x in 80x driver
In-Reply-To: <201206291421.40717.arnd@arndb.de>
References: <1340853214-5429-1-git-send-email-zhouqiao@marvell.com>
 <1340853214-5429-2-git-send-email-zhouqiao@marvell.com>
 <201206291421.40717.arnd@arndb.de>
Message-ID: <20120630120237.GY28922@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2012 at 02:21:40PM +0000, Arnd Bergmann wrote:

> One more question I have about this, mainly for Mark:

> I understand that by passing -1 into regmap_add_irq_chip, it should allocate
> its own linear irq domain rather using a legacy domain. Does that require
> any other changes? Should the drivers that use the irq number just use
> regmap_irq_get_virq() to get the linux irq number, or is there more to do
> here?

That's it - the users don't need to worry about where the Linux IRQ
number came from, they can just call that function and it'll give them
something they can use regardless if it's a linear, legacy or something
else domain.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120630/315a6610/attachment.sig>
