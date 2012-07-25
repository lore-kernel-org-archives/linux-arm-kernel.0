From: tim.gardner@canonical.com (Tim Gardner)
Date: Wed, 25 Jul 2012 12:33:06 -0600
Subject: [PATCH] ixp4xx: Declare MODULE_FIRMWARE usage
Message-ID: <1343241186-103293-1-git-send-email-tim.gardner@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---
 arch/arm/mach-ixp4xx/ixp4xx_npe.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ixp4xx/ixp4xx_npe.c b/arch/arm/mach-ixp4xx/ixp4xx_npe.c
index a17ed79..d4eb09a 100644
--- a/arch/arm/mach-ixp4xx/ixp4xx_npe.c
+++ b/arch/arm/mach-ixp4xx/ixp4xx_npe.c
@@ -116,7 +116,11 @@
 /* NPE mailbox_status value for reset */
 #define RESET_MBOX_STAT			0x0000F0F0
 
-const char *npe_names[] = { "NPE-A", "NPE-B", "NPE-C" };
+#define NPE_A_FIRMWARE "NPE-A"
+#define NPE_B_FIRMWARE "NPE-B"
+#define NPE_C_FIRMWARE "NPE-C"
+
+const char *npe_names[] = { NPE_A_FIRMWARE, NPE_B_FIRMWARE, NPE_C_FIRMWARE };
 
 #define print_npe(pri, npe, fmt, ...)					\
 	printk(pri "%s: " fmt, npe_name(npe), ## __VA_ARGS__)
@@ -724,6 +728,9 @@ module_exit(npe_cleanup_module);
 
 MODULE_AUTHOR("Krzysztof Halasa");
 MODULE_LICENSE("GPL v2");
+MODULE_FIRMWARE(NPE_A_FIRMWARE);
+MODULE_FIRMWARE(NPE_B_FIRMWARE);
+MODULE_FIRMWARE(NPE_C_FIRMWARE);
 
 EXPORT_SYMBOL(npe_names);
 EXPORT_SYMBOL(npe_running);
-- 
1.7.9.5
