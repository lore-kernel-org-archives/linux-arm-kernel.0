From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 21 Jun 2016 10:37:16 +0800
Subject: [PATCH] ARM: imx6q: export cpuidle functions needed by fec driver
Message-ID: <1466476636-25204-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Export cpuidle functions needed by fec driver to fix the issue below
seen with fec module build.

ERROR: "imx6q_cpuidle_fec_irqs_unused" [drivers/net/ethernet/freescale/fec.ko] undefined!
ERROR: "imx6q_cpuidle_fec_irqs_used" [drivers/net/ethernet/freescale/fec.ko] undefined!

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
 arch/arm/mach-imx/cpuidle-imx6q.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
index c3cc8ca8d2ff..eed176e6d65e 100644
--- a/arch/arm/mach-imx/cpuidle-imx6q.c
+++ b/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -72,11 +72,13 @@ void imx6q_cpuidle_fec_irqs_used(void)
 {
 	imx6q_cpuidle_driver.states[1].disabled = true;
 }
+EXPORT_SYMBOL_GPL(imx6q_cpuidle_fec_irqs_used);
 
 void imx6q_cpuidle_fec_irqs_unused(void)
 {
 	imx6q_cpuidle_driver.states[1].disabled = false;
 }
+EXPORT_SYMBOL_GPL(imx6q_cpuidle_fec_irqs_unused);
 
 int __init imx6q_cpuidle_init(void)
 {
-- 
1.9.1
