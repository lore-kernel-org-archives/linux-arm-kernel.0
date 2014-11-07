From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 6 Nov 2014 23:09:47 -0500
Subject: [PATCH 03/17] irqchip: irq-armada-370-xp: use proper return
 value for ->set_affinity()
In-Reply-To: <1414151970-6626-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20141107040947.GG3698@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 01:59:16PM +0200, Thomas Petazzoni wrote:
> The ->set_affinity() hook of 'struct irq_chip' is supposed to return
> one of IRQ_SET_MASK_OK or IRQ_SET_MASK_OK_NOCOPY. However, the code
> currently simply returns 0. This patch fixes that by using
> IRQ_SET_MASK_OK, which tells the IRQ core that it is responsible for
> updating irq_data.affinity.
> 
> Note that this patch does not cause any change to the compiled code,
> as IRQ_SET_MASK_OK has the value 0. This is therefore just a simple
> cleanup.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/irqchip/irq-armada-370-xp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to irqchip/core with Gregory's Reviewed-by.

thx,

Jason.
