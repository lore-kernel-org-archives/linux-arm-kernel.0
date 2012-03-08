From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 8 Mar 2012 17:41:16 +0000
Subject: [PATCH 06/14] ARM: kirkwood: convert uart0 to devicetree.
In-Reply-To: <201203081701.01663.arnd@arndb.de>
References: <cover.1331090356.git.jason@lakedaemon.net>
 <20120308162530.GI5050@titan.lakedaemon.net>
 <201203081701.01663.arnd@arndb.de>
Message-ID: <201203081741.16412.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 March 2012, Arnd Bergmann wrote:

> Since the orion irq chip is based on irqchip_generic, it would be
> perfect to have a generic irqchip binding to go along with
> kernel/irq/generic-chip.c. Not sure if anyone has thought about this
> before, but it looks like we can completely avoid using
> arch/arm/plat-orion/irq.c and arch/arm/mach-kirkwood/irq.c if we
> do that.
> 

One more thing about the interrupt controller changes: The arm-soc
tree includes Grants "irqchip" branch, and the tegra/soc-drivers
and at91/dt branches are building on top of that. Please have a look
at what they do so you can do the same.

	Arnd
