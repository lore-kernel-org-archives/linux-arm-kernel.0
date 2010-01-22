From: colin.tuckley@arm.com (Colin Tuckley)
Date: Fri, 22 Jan 2010 10:07:16 +0000
Subject: [PATCH] ARM: Fix the reset on the RealView PBX Development board
Message-ID: <20100122100716.13091.35627.stgit@ARM03585.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Colin Tuckley <colin.tuckley@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mach-realview/realview_pbx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 7469ce2..08ff5d3 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -334,8 +334,8 @@ static void realview_pbx_reset(char mode)
 	 * in the system FPGA
 	 */
 	__raw_writel(REALVIEW_SYS_LOCK_VAL, lock_ctrl);
-	__raw_writel(0x0000, reset_ctrl);
-	__raw_writel(0x0004, reset_ctrl);
+	__raw_writel(0x00F0, reset_ctrl);
+	__raw_writel(0x00F4, reset_ctrl);
 }
 
 static void __init realview_pbx_init(void)
