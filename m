From: olof@lixom.net (Olof Johansson)
Date: Sun,  7 Oct 2012 10:42:40 -0700
Subject: [PATCH] ARM: integrator_cp: fix build failure
Message-ID: <1349631760-21350-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-integrator/integrator_cp.c:272:32: error: 'of_aliases'
undeclared (first use in this function)

Move the OF-only timer init under #ifdef CONFIG_OF, just like
integrator_ap has it.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-integrator/integrator_cp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 6870a1f..5b08e8e 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -261,6 +261,8 @@ static void __init intcp_init_early(void)
 #endif
 }
 
+#ifdef CONFIG_OF
+
 static void __init intcp_timer_init_of(void)
 {
 	struct device_node *node;
@@ -297,8 +299,6 @@ static struct sys_timer cp_of_timer = {
 	.init		= intcp_timer_init_of,
 };
 
-#ifdef CONFIG_OF
-
 static const struct of_device_id fpga_irq_of_match[] __initconst = {
 	{ .compatible = "arm,versatile-fpga-irq", .data = fpga_irq_of_init, },
 	{ /* Sentinel */ }
-- 
1.7.10.1.488.g05fbf7a
