From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 13 Jun 2016 00:52:36 +0000
Subject: [PATCH] irqchip/sirfsoc: fix sparse warnings on __iomem
In-Reply-To: <1465301910-2308-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465301910-2308-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160613005236.GG24391@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

On Tue, Jun 07, 2016 at 01:18:30PM +0100, Ben Dooks wrote:
> Fix warnings from sparse about casting to __iomem from non anotated
> variable:
> 
> drivers/irqchip/irq-sirfsoc.c:56:47: warning: incorrect type in initializer (different address spaces)
> drivers/irqchip/irq-sirfsoc.c:56:47:    expected void [noderef] <asn:2>*base
> drivers/irqchip/irq-sirfsoc.c:56:47:    got void *host_data
> drivers/irqchip/irq-sirfsoc.c:97:47: warning: incorrect type in initializer (different address spaces)
> drivers/irqchip/irq-sirfsoc.c:97:47:    expected void [noderef] <asn:2>*base
> drivers/irqchip/irq-sirfsoc.c:97:47:    got void *host_data
> drivers/irqchip/irq-sirfsoc.c:109:47: warning: incorrect type in initializer (different address spaces)
> drivers/irqchip/irq-sirfsoc.c:109:47:    expected void [noderef] <asn:2>*base
> drivers/irqchip/irq-sirfsoc.c:109:47:    got void *host_data
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  drivers/irqchip/irq-sirfsoc.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Applied to irqchip/misc

thx,

Jason.
