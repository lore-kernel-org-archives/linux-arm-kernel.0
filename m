From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 10 Jun 2016 17:49:27 +0200
Subject: [PATCH] irqchip/tegra: fix fix sparse warnings on __iomem
In-Reply-To: <1465302292-4840-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465302292-4840-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160610154927.GR27142@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 01:24:52PM +0100, Ben Dooks wrote:
> Fix the following warnings from sparse due to casting to/from __iomem
> annotated variables:
> 
> drivers/irqchip/irq-tegra.c:93:31: warning: incorrect type in initializer (different address spaces)
> drivers/irqchip/irq-tegra.c:93:31:    expected void [noderef] <asn:2>*base
> drivers/irqchip/irq-tegra.c:93:31:    got void *chip_data
> drivers/irqchip/irq-tegra.c:93:31: warning: incorrect type in initializer (different address spaces)
> drivers/irqchip/irq-tegra.c:93:31:    expected void [noderef] <asn:2>*base
> drivers/irqchip/irq-tegra.c:93:31:    got void *chip_data
> drivers/irqchip/irq-tegra.c:93:31: warning: incorrect type in initializer (different address spaces)
> drivers/irqchip/irq-tegra.c:93:31:    expected void [noderef] <asn:2>*base
> drivers/irqchip/irq-tegra.c:93:31:    got void *chip_data
> drivers/irqchip/irq-tegra.c:93:31: warning: incorrect type in initializer (different address spaces)
> drivers/irqchip/irq-tegra.c:93:31:    expected void [noderef] <asn:2>*base
> drivers/irqchip/irq-tegra.c:93:31:    got void *chip_data
> drivers/irqchip/irq-tegra.c:269:57: warning: incorrect type in argument 5 (different address spaces)
> drivers/irqchip/irq-tegra.c:269:57:    expected void *chip_data
> drivers/irqchip/irq-tegra.c:269:57:    got void [noderef] <asn:2>*<noident>
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: linux-tegra at vger.kernel.org
> ---
>  drivers/irqchip/irq-tegra.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160610/eeb4edfa/attachment.sig>
