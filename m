From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu, 18 Jul 2013 22:34:52 +0400
Subject: [PATCH 01/10] ARM: clps711x: Remove the special name for the syscon
 driver
In-Reply-To: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
Message-ID: <1374172501-26796-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a partial revert of the patch:
"6597619f9c ARM: clps711x: Add support for SYSCON driver".
No reason to make SYSCON driver name unique to that processor.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/devices.c | 2 +-
 drivers/mfd/syscon.c             | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-clps711x/devices.c b/arch/arm/mach-clps711x/devices.c
index 856b81c..fb77d14 100644
--- a/arch/arm/mach-clps711x/devices.c
+++ b/arch/arm/mach-clps711x/devices.c
@@ -57,7 +57,7 @@ static void __init clps711x_add_syscon(void)
 	unsigned i;
 
 	for (i = 0; i < ARRAY_SIZE(clps711x_syscon_res); i++)
-		platform_device_register_simple("clps711x-syscon", i + 1,
+		platform_device_register_simple("syscon", i + 1,
 						&clps711x_syscon_res[i], 1);
 }
 
diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 1a31512..962a6e1 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -159,9 +159,6 @@ static int syscon_probe(struct platform_device *pdev)
 
 static const struct platform_device_id syscon_ids[] = {
 	{ "syscon", },
-#ifdef CONFIG_ARCH_CLPS711X
-	{ "clps711x-syscon", },
-#endif
 	{ }
 };
 
-- 
1.8.1.5
