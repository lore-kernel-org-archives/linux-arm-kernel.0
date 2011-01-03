From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Jan 2011 15:27:15 +0000
Subject: [PATCH 02/04] ARM i.MX25 Add SIM driver
In-Reply-To: <4D21E53E.2050809@fqingenieria.es>
References: <20736.212.121.242.58.1294045639.squirrel@mail.fqingenieria.es>
	<20110103130551.GA24408@pengutronix.de>
	<4D21E53E.2050809@fqingenieria.es>
Message-ID: <20110103152715.GB32508@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 03, 2011 at 04:03:26PM +0100, Jaume Ribot wrote:
> IMHO, there is  
> no conceptual difference between this driver and any of the others  
> contained into plat-mxc/ directory. That's also why this driver has not  
> been placed into drivers/ directory.

I repeat, drivers for user interfaces should be in the drivers/ subtree
and not the arch/ subtree.  It's something that Linus Torvalds has
complained about, and it's a practice that needs to stop right now if we
want to continue being part of mainline.

I don't see anything in plat-mxc registering itself as user visible driver.
The only things I see are low level such as cpufreq drivers, clocksource/
clockevent code, gpio and pwm services.  So, there's no precident in
plat-mxc for user visible device drivers.

The problem is that no one expects user visible device drivers in the
arch/ tree, and so they will get missed when updates to their kernel APIs
happen.
