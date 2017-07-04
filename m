From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 4 Jul 2017 11:12:46 +0100
Subject: [PATCH 1/3] irqchip/atmel-aic: Fix unbalanced of_node_put() in
 aic_common_irq_fixup()
In-Reply-To: <1499159441-29801-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1499159441-29801-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1db44d6a-22fc-7364-558f-3b65bfd69355@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/17 10:10, Boris Brezillon wrote:
> aic_common_irq_fixup() is calling twice of_node_put() on the same node
> thus leading to an unbalanced refcount on the root node.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Reported-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Fixes: b2f579b58e93 ("irqchip: atmel-aic: Add irq fixup infrastructure")
> Cc: <stable@vger.kernel.org>

All 3 patches queued for post -rc1.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
