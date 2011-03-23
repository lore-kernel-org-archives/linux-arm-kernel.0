From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 23 Mar 2011 11:04:21 +0100
Subject: [PATCH 2/6] mach-ux500: delete SSP PrimeCell ID
Message-ID: <1300874661-14747-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This is redundant. The correct ID number is right there in the
hardware anyway. We will introduce a mechanism later to hard-code
this for deviant cells.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/devices-db8500.h        |    2 +-
 arch/arm/mach-ux500/include/mach/hardware.h |    3 ---
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-ux500/devices-db8500.h b/arch/arm/mach-ux500/devices-db8500.h
index 9cc6f8f..e341ad0 100644
--- a/arch/arm/mach-ux500/devices-db8500.h
+++ b/arch/arm/mach-ux500/devices-db8500.h
@@ -25,7 +25,7 @@ static inline struct amba_device *
 db8500_add_ssp(const char *name, resource_size_t base, int irq,
 	       struct pl022_ssp_controller *pdata)
 {
-	return dbx500_add_amba_device(name, base, irq, pdata, SSP_PER_ID);
+	return dbx500_add_amba_device(name, base, irq, pdata, 0);
 }
 
 
diff --git a/arch/arm/mach-ux500/include/mach/hardware.h b/arch/arm/mach-ux500/include/mach/hardware.h
index bf63f26..d54bb61 100644
--- a/arch/arm/mach-ux500/include/mach/hardware.h
+++ b/arch/arm/mach-ux500/include/mach/hardware.h
@@ -29,9 +29,6 @@
 #include <mach/db8500-regs.h>
 #include <mach/db5500-regs.h>
 
-/* ST-Ericsson modified pl022 id */
-#define SSP_PER_ID		0x01080022
-
 #ifndef __ASSEMBLY__
 
 #include <mach/id.h>
-- 
1.7.3.2
