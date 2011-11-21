From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 21 Nov 2011 16:26:52 -0200
Subject: [PATCH] ARM: mx5: Fix checkpatch warnings in cpu-imx5.c
In-Reply-To: <1321900012-8351-1-git-send-email-fabio.estevam@freescale.com>
References: <1321900012-8351-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1321900012-8351-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following warnings reported by checkpatch:

WARNING: Use #include <linux/io.h> instead of <asm/io.h>
#19: FILE: arm/mach-imx/cpu-imx5.c:19:
+#include <asm/io.h>

WARNING: line over 80 characters
#70: FILE: arm/mach-imx/cpu-imx5.c:70:
+	if (mx51_revision() < IMX_CHIP_REVISION_3_0 && (elf_hwcap & HWCAP_NEON)) {

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---

This is based on Sascha's mx5-merge tree.

 arch/arm/mach-imx/cpu-imx5.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/cpu-imx5.c b/arch/arm/mach-imx/cpu-imx5.c
index 5c53282..8bbeb2a 100644
--- a/arch/arm/mach-imx/cpu-imx5.c
+++ b/arch/arm/mach-imx/cpu-imx5.c
@@ -16,7 +16,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <mach/hardware.h>
-#include <asm/io.h>
+#include <linux/io.h>
 
 static int mx5_cpu_rev = -1;
 
@@ -67,7 +67,8 @@ static int __init mx51_neon_fixup(void)
 	if (!cpu_is_mx51())
 		return 0;
 
-	if (mx51_revision() < IMX_CHIP_REVISION_3_0 && (elf_hwcap & HWCAP_NEON)) {
+	if (mx51_revision() < IMX_CHIP_REVISION_3_0 &&
+					(elf_hwcap & HWCAP_NEON)) {
 		elf_hwcap &= ~HWCAP_NEON;
 		pr_info("Turning off NEON support, detected broken NEON implementation\n");
 	}
-- 
1.7.1
