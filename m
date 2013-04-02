From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  2 Apr 2013 14:21:48 +0100
Subject: [PATCH 1/9] ARM: ux500: Increase the size of the PRCMU's TCPM size
Message-ID: <1364908916-29803-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Tightly Coupled Program Memory location is actually 32kB in
size, rather than the originally depicted 4kB.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/devices-db8500.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/devices-db8500.c b/arch/arm/mach-ux500/devices-db8500.c
index f3d9419..afa5b04 100644
--- a/arch/arm/mach-ux500/devices-db8500.c
+++ b/arch/arm/mach-ux500/devices-db8500.c
@@ -225,7 +225,7 @@ static struct resource db8500_prcmu_res[] = {
 	{
 		.name  = "prcmu-tcpm",
 		.start = U8500_PRCMU_TCPM_BASE,
-		.end   = U8500_PRCMU_TCPM_BASE + SZ_4K - 1,
+		.end   = U8500_PRCMU_TCPM_BASE + SZ_32K - 1,
 		.flags = IORESOURCE_MEM,
 	},
 };
-- 
1.7.10.4
