From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 14 Dec 2011 22:39:58 +0000
Subject: [PATCH 2/2] ARM: vic: always use simple ops
In-Reply-To: <1323902398-10072-1-git-send-email-jamie@jamieiles.com>
References: <1323902398-10072-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1323902398-10072-2-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that irq_domain_simple_ops are available for non-DT users, use them
in the VIC driver so that we don't get a NULL dereference in
irq_domain_to_irq() when registering the domain.

Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: Russell King <rmk+linux@arm.linux.org.uk>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/common/vic.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index 7728750..dcb004a 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -197,8 +197,8 @@ static void __init vic_register(void __iomem *base, unsigned int irq,
 	v->domain.nr_irq = 32;
 #ifdef CONFIG_OF_IRQ
 	v->domain.of_node = of_node_get(node);
-	v->domain.ops = &irq_domain_simple_ops;
 #endif /* CONFIG_OF */
+	v->domain.ops = &irq_domain_simple_ops;
 	irq_domain_add(&v->domain);
 }
 
-- 
1.7.5.4
