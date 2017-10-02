From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 2 Oct 2017 19:58:02 +0200
Subject: [PATCH 1/6] ARM: s3c24xx: Delete an error message for a failed memory
 allocation in s3c2410_iotiming_get()
In-Reply-To: <d2ae00c8-da57-9ffc-3692-67ed6daa95e0@users.sourceforge.net>
References: <d2ae00c8-da57-9ffc-3692-67ed6daa95e0@users.sourceforge.net>
Message-ID: <1207a56d-3fa6-9c80-d9fe-4b56b11ff0a7@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 2 Oct 2017 19:14:20 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-s3c24xx/iotiming-s3c2410.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/iotiming-s3c2410.c b/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
index b7970f1fa3d5..f587c78fba33 100644
--- a/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
+++ b/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
@@ -454,10 +454,8 @@ int s3c2410_iotiming_get(struct s3c_cpufreq_config *cfg,
 			       __func__, bank, bankcon);
 
 		bt = kzalloc(sizeof(struct s3c2410_iobank_timing), GFP_KERNEL);
-		if (!bt) {
-			printk(KERN_ERR "%s: no memory for bank\n", __func__);
+		if (!bt)
 			return -ENOMEM;
-		}
 
 		/* find out in nWait is enabled for bank. */
 
-- 
2.14.2
