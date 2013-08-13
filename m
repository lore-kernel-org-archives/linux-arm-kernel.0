From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 13 Aug 2013 10:28:02 -0300
Subject: [PATCH] ARM: mach-mxs: Remove "TO" string from revision field
Message-ID: <1376400482-23442-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

There is no need to print the silicon revision as "TO1.2", just print it as 
"1.2" instead:

$ cat /sys/bus/soc/devices/soc0/revision
1.2

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mxs/mach-mxs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 2d7ad51..98f6e2a 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -396,7 +396,7 @@ static const char __init *mxs_get_revision(void)
 	u32 rev = mxs_get_cpu_rev();
 
 	if (rev != MXS_CHIP_REV_UNKNOWN)
-		return kasprintf(GFP_KERNEL, "TO%d.%d", (rev >> 4) & 0xf,
+		return kasprintf(GFP_KERNEL, "%d.%d", (rev >> 4) & 0xf,
 				rev & 0xf);
 	else
 		return kasprintf(GFP_KERNEL, "%s", "Unknown");
-- 
1.8.1.2
