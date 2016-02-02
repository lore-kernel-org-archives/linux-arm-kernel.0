From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 2 Feb 2016 16:46:18 +0000
Subject: [PATCH v3] irqchip: gicv3-its: Fix memory leak in
 its_free_tables()
In-Reply-To: <1454379584-21772-1-git-send-email-shankerd@codeaurora.org>
References: <1454379584-21772-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <56B0DD5A.3080500@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/16 02:19, Shanker Donthineni wrote:
> The current ITS driver has a memory leak in its_free_tables(). It
> happens on tear down path of the driver when its_probe() call fails.
> its_free_tables() should free the exact number of pages that have
> been allocated, not just a single page as current code does.
> 
> This patch records the memory size for each ITS_BASERn at the time of
> page allocation and uses the same size information when freeing pages
> to fix the issue.
> 
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
