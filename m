From: ccross@android.com (Colin Cross)
Date: Wed, 30 Mar 2011 00:30:37 -0700
Subject: [PATCH] ARM: tegra: gpio: Fix unused variable warnings
Message-ID: <1301470237-5231-1-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change b0f18edaf6ee4e6fac89cae63a90bd38ad2a3418
(arm: tegra: Remove unused bogus irq enable/disable magic)
introduces warnings:
arch/arm/mach-tegra/gpio.c: In function 'tegra_gpio_resume':
arch/arm/mach-tegra/gpio.c:260: warning: unused variable 'i'
arch/arm/mach-tegra/gpio.c: In function 'tegra_gpio_suspend':
arch/arm/mach-tegra/gpio.c:283: warning: unused variable 'i'

Fix them, and fix a coding style issue on the same lines.

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/mach-tegra/gpio.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/gpio.c b/arch/arm/mach-tegra/gpio.c
index 76a3f65..65a1aba 100644
--- a/arch/arm/mach-tegra/gpio.c
+++ b/arch/arm/mach-tegra/gpio.c
@@ -257,7 +257,8 @@ static void tegra_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 void tegra_gpio_resume(void)
 {
 	unsigned long flags;
-	int b, p, i;
+	int b;
+	int p;
 
 	local_irq_save(flags);
 
@@ -280,7 +281,8 @@ void tegra_gpio_resume(void)
 void tegra_gpio_suspend(void)
 {
 	unsigned long flags;
-	int b, p, i;
+	int b;
+	int p;
 
 	local_irq_save(flags);
 	for (b = 0; b < ARRAY_SIZE(tegra_gpio_banks); b++) {
-- 
1.7.4.1
