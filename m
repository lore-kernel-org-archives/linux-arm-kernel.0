From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 8 Jul 2014 18:31:45 -0400
Subject: [PATCH v6 01/21] irqchip: ARM: GIC: Move some bits of GICv2 to
 a library-type file
In-Reply-To: <1404140510-5382-2-git-send-email-marc.zyngier@arm.com>
References: <1404140510-5382-1-git-send-email-marc.zyngier@arm.com>
 <1404140510-5382-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140708223145.GG13433@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

On Mon, Jun 30, 2014 at 04:01:30PM +0100, Marc Zyngier wrote:
> A few GICv2 low-level function are actually very useful to GICv3,
> and it makes some sense to share them across the two drivers.
> They end-up in their own file, with an additional parameter used
> to ensure an optional synchronization (unused on GICv2).
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/irqchip/Makefile         |   2 +-
>  drivers/irqchip/irq-gic-common.c | 115 +++++++++++++++++++++++++++++++++++++++
>  drivers/irqchip/irq-gic-common.h |  29 ++++++++++
>  drivers/irqchip/irq-gic.c        |  59 ++------------------
>  4 files changed, 149 insertions(+), 56 deletions(-)
>  create mode 100644 drivers/irqchip/irq-gic-common.c
>  create mode 100644 drivers/irqchip/irq-gic-common.h

I've now applied this and patch #2 to irqchip/gic.  It'll be in -next
tonight, and I'll merge it into /core at some point in the future.
Probably after the other gic changes go on top of this.

At any rate, unless you tell me it's all fouled up, this branch is
stable.  Since I'll be adding more stuff on top, I've tagged this for
you guys to pull:

  git://git.infradead.org/users/jcooper/linux.git  tags/deps-irqchip-gic-3.17

Please wait to send your pull request for changes depending on this
branch until after you see Thomas send Linus the request for irq/core.

thx,

Jason.
