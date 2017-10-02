From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 2 Oct 2017 20:01:28 +0200
Subject: [PATCH 4/6] ARM: s3c24xx: Delete an error message for a failed memory
 allocation in s3c2412_iotiming_get()
In-Reply-To: <d2ae00c8-da57-9ffc-3692-67ed6daa95e0@users.sourceforge.net>
References: <d2ae00c8-da57-9ffc-3692-67ed6daa95e0@users.sourceforge.net>
Message-ID: <381d4a29-d777-93ee-ed4d-3f41a5ed97cc@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 2 Oct 2017 19:37:07 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-s3c24xx/iotiming-s3c2412.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/iotiming-s3c2412.c b/arch/arm/mach-s3c24xx/iotiming-s3c2412.c
index 28b13951de87..f09d5d5ea7ed 100644
--- a/arch/arm/mach-s3c24xx/iotiming-s3c2412.c
+++ b/arch/arm/mach-s3c24xx/iotiming-s3c2412.c
@@ -243,10 +243,8 @@ int s3c2412_iotiming_get(struct s3c_cpufreq_config *cfg,
 			continue;
 
 		bt = kzalloc(sizeof(struct s3c2412_iobank_timing), GFP_KERNEL);
-		if (!bt) {
-			printk(KERN_ERR "%s: no memory for bank\n", __func__);
+		if (!bt)
 			return -ENOMEM;
-		}
 
 		timings->bank[bank].io_2412 = bt;
 		s3c2412_iotiming_getbank(cfg, bt, bank);
-- 
2.14.2
