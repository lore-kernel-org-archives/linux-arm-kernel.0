From: jason@lakedaemon.net (Jason)
Date: Thu, 8 Mar 2012 11:25:30 -0500
Subject: [PATCH 06/14] ARM: kirkwood: convert uart0 to devicetree.
In-Reply-To: <201203072113.04369.arnd@arndb.de>
References: <cover.1331090356.git.jason@lakedaemon.net>
 <201203071831.31738.arnd@arndb.de>
 <20120307192723.GE5050@titan.lakedaemon.net>
 <201203072113.04369.arnd@arndb.de>
Message-ID: <20120308162530.GI5050@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2012 at 09:13:04PM +0000, Arnd Bergmann wrote:
> Finally, something could be wrong with the interrupt controller.
> AFAICT, you register it through the device tree now, but it's also
> getting initialized through kirkwood_init_irq, so the numbers
> would all be wrong.

Yes, I'm working through this now.  mv_cesa silently fails to come up
if it can't find the interrupt controller via fdt.  So, it needs to get
done.

Right now, I'm looking at how mach-versatile does it (vic_init()) since
it's also an ARM926ej-s...

thx,

Jason.
