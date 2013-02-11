From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 11 Feb 2013 12:01:47 -0200
Subject: [PATCH 2/3] ARM: mxs: icoll: Fix sparse warning
In-Reply-To: <1360591308-7482-1-git-send-email-festevam@gmail.com>
References: <1360591308-7482-1-git-send-email-festevam@gmail.com>
Message-ID: <1360591308-7482-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Fix the following sparse warning:

arch/arm/mach-mxs/icoll.c:103:13: warning: symbol 'icoll_of_init' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mxs/icoll.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mxs/icoll.c b/arch/arm/mach-mxs/icoll.c
index 8fb23af..e26eeba 100644
--- a/arch/arm/mach-mxs/icoll.c
+++ b/arch/arm/mach-mxs/icoll.c
@@ -100,7 +100,7 @@ static struct irq_domain_ops icoll_irq_domain_ops = {
 	.xlate = irq_domain_xlate_onecell,
 };
 
-void __init icoll_of_init(struct device_node *np,
+static void __init icoll_of_init(struct device_node *np,
 			  struct device_node *interrupt_parent)
 {
 	/*
-- 
1.7.9.5
