From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 4 May 2012 12:20:42 +0200
Subject: common clock framework
In-Reply-To: <AAD1C6EB06EE3649B35B7E026785068D1A74A942DB@SC-VEXCH2.marvell.com>
References: <AAD1C6EB06EE3649B35B7E026785068D1A74A94270@SC-VEXCH2.marvell.com>
 <20120504082110.GB16535@pengutronix.de>
 <AAD1C6EB06EE3649B35B7E026785068D1A74A942DB@SC-VEXCH2.marvell.com>
Message-ID: <20120504102042.GL4141@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please do not top post.

On Fri, May 04, 2012 at 01:45:15AM -0700, Chao Xie wrote:
> Hi
> For the clock dependency, what about bus clock. What do you mean about
> bus level.  As I understand the device driver only need care about
> enabling a clock to make it work. For example a USB driver. To make a
> USB work, it may need turn on bus clock, function clock, and phy
> clock. For some SOCs, phy and function may share same clock. There is
> a problem, we leave this dependency to device driver or keep it in our
> clock framework.  To keep it in clock framework, the device driver
> only need know that enable one clock. To leave the dependency to
> device driver, the device driver will need know about all the clocks
> and dependency. If the device driver is shared by many SOCs, it will
> add some #ifdef into it.  So why not add a dependency list into clock
> structure, and it will do enable the dependency clock before enable
> its own clock.

Additional to what Russell already said:
If a clock is not needed by the device directly but for example by the
bus which connects the device, then you need an instance which controls
the bus. Then it's the bus that knows which clocks to activate when a
device on this bus is activated. That said, there currently is hardly
any infrastructure for this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
