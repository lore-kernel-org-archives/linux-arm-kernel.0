From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 7 Nov 2013 11:16:42 +0800
Subject: [PATCH V2 2/4] arm: imx: make use of common scu_a9_get_base()
 interface
In-Reply-To: <1383794204-4714-1-git-send-email-jszhang@marvell.com>
References: <1383794204-4714-1-git-send-email-jszhang@marvell.com>
Message-ID: <1383794204-4714-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of common scu_a9_get_base() and delete the comment since the
interface is self commented.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/mach-imx/platsmp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index 1f24c1f..369a566 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -35,8 +35,7 @@ void __init imx_scu_map_io(void)
 {
 	unsigned long base;
 
-	/* Get SCU base */
-	asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (base));
+	base = scu_a9_get_base();
 
 	scu_io_desc.virtual = IMX_IO_P2V(base);
 	scu_io_desc.pfn = __phys_to_pfn(base);
-- 
1.8.4.2
