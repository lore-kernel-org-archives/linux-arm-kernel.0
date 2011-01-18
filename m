From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 18 Jan 2011 13:29:33 -0700
Subject: [PATCH 7/8] arm/tegra: Fix tegra irq_data conversion
In-Reply-To: <20110118195933.13011.56098.stgit@localhost6.localdomain6>
References: <20110118195933.13011.56098.stgit@localhost6.localdomain6>
Message-ID: <20110118202933.13011.50322.stgit@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 37337a8d5e68d6e19075dbdb3acf4f1011dae972, "ARM: tegra: irq_data
conversion." missed changing one reference to 'irq' in the function
tegra_gpio_irq_set_type().  This patch fixes the build error.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/mach-tegra/gpio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/gpio.c b/arch/arm/mach-tegra/gpio.c
index bd06620..ad80488 100644
--- a/arch/arm/mach-tegra/gpio.c
+++ b/arch/arm/mach-tegra/gpio.c
@@ -207,9 +207,9 @@ static int tegra_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	spin_unlock_irqrestore(&bank->lvl_lock[port], flags);
 
 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
-		__set_irq_handler_unlocked(irq, handle_level_irq);
+		__set_irq_handler_unlocked(d->irq, handle_level_irq);
 	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
-		__set_irq_handler_unlocked(irq, handle_edge_irq);
+		__set_irq_handler_unlocked(d->irq, handle_edge_irq);
 
 	return 0;
 }
