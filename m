From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 17 Jul 2014 09:34:49 -0400
Subject: [PATCH v4 0/7] ARM: at91: move aic driver to drivers/irqchips
In-Reply-To: <1405012462-766-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1405012462-766-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140717133449.GP13108@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 07:14:15PM +0200, Boris BREZILLON wrote:
> Hello,
> 
> This series moves the AIC driver to the irqchip directory and make use of
> the generic chip framework whenever possible.
> 
> This driver only support DT boards (all legacy board files should be soon
> replaced by their DT versions).
> 
> Since the last version AIC and AIC5 code have been split and common
> functions have been moved to irq-atmel-aic-common.c.
> I know there is not much code in this file and it could have been
> duplicated in AIC and AIC5 drivers, but I'm planning to add more common
> stuff soon (AIC irq fixups previously done in
> arch/arm/mach-at91/sysirq_mask.c).
> 
> Jason, if everybody is fine with this version could you share a topic
> branch  containing patch 1 to 3 with Nicolas ?

I've now applied patches 1-3 to irqchip/atmel-aic.  You can find the
branch here:

  git://git.infradead.org/users/jcooper/linux.git irqchip/atmel-aic

It will be merged into -next today, and I'll merge it into irqchip/core
after a few days.

thx,

Jason.
