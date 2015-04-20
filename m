From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Mon, 20 Apr 2015 10:42:52 -0500
Subject: [PATCH RESEND 2/2] ARM: socfpga: remove the need to map uart_io_desc
In-Reply-To: <1429544572-22421-1-git-send-email-dinguyen@opensource.altera.com>
References: <1429544572-22421-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1429544572-22421-2-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

All the necessary debug uart mapping is already being done in
debug_ll_io_init, there's no need for it here.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-socfpga/socfpga.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index f5e597c..358f2c7 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -39,13 +39,6 @@ static struct map_desc scu_io_desc __initdata = {
 	.type		= MT_DEVICE,
 };
 
-static struct map_desc uart_io_desc __initdata = {
-	.virtual	= 0xfec02000,
-	.pfn		= __phys_to_pfn(0xffc02000),
-	.length		= SZ_8K,
-	.type		= MT_DEVICE,
-};
-
 static void __init socfpga_scu_map_io(void)
 {
 	unsigned long base;
@@ -60,8 +53,6 @@ static void __init socfpga_scu_map_io(void)
 static void __init socfpga_map_io(void)
 {
 	socfpga_scu_map_io();
-	iotable_init(&uart_io_desc, 1);
-	early_printk("Early printk initialized\n");
 }
 
 void __init socfpga_sysmgr_init(void)
-- 
2.2.1
