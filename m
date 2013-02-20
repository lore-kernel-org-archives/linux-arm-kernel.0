From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Wed, 20 Feb 2013 09:29:16 +0100
Subject: [PATCH] ARM: ux500: read the correct soc_id number
Message-ID: <1361348956-4387-1-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix db8500_read_soc_id() to read all five soc_id number locations
instead of repeating the second one two times.

Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 5b286e0..4b5602b 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -199,7 +199,7 @@ static const char *db8500_read_soc_id(void)
 	/* Throw these device-specific numbers into the entropy pool */
 	add_device_randomness(uid, 0x14);
 	return kasprintf(GFP_KERNEL, "%08x%08x%08x%08x%08x",
-			 readl((u32 *)uid+1),
+			 readl((u32 *)uid+0),
 			 readl((u32 *)uid+1), readl((u32 *)uid+2),
 			 readl((u32 *)uid+3), readl((u32 *)uid+4));
 }
-- 
1.7.12.1
