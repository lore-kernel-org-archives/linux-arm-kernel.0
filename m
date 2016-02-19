From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 19 Feb 2016 15:59:41 +0000
Subject: [PATCH] irqchip/gic: Return IRQ_SET_MASK_OK_DONE in the
 set_affinity method
In-Reply-To: <1455894029-17270-1-git-send-email-marc.zyngier@arm.com>
References: <1455894029-17270-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160219155941.GE958@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 03:00:29PM +0000, Marc Zyngier wrote:
> Moving an SPI around doesn't require any extra work from the rest
> of the stack, and specially not for MSI-generated SPIs.
> 
> It is then worth returning IRQ_SET_MASK_OK_DONE instead of
> IRQ_SET_MASK_OK, and simplify the other irqchips that rely on
> this behaviour (GICv2m and Marvell's ODMI controller).
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/irqchip/irq-gic-v2m.c    | 14 +-------------
>  drivers/irqchip/irq-gic.c        |  2 +-
>  drivers/irqchip/irq-mvebu-odmi.c | 14 +-------------
>  3 files changed, 3 insertions(+), 27 deletions(-)

Applied to irchip/mvebu with Thomas' (P) Acked-by.

thx,

Jason.
