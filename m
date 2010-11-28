From: jekhor@gmail.com (Yauhen Kharuzhy)
Date: Sun, 28 Nov 2010 20:30:26 +0200
Subject: [PATCH 08/10] ARM SAMSUNG: Don't export __init functions to modules
In-Reply-To: <1290969027-10178-1-git-send-email-jekhor@gmail.com>
References: <1290969027-10178-1-git-send-email-jekhor@gmail.com>
Message-ID: <1290969027-10178-8-git-send-email-jekhor@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are few functions marked as __init, but exported to modules in
devices declaration files.

s3c_nand_set_platdata() and s3c24xx_ts_set_platdata() are used only by
boards init code now, so remove EXPORT_SYMBOL() for them.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 arch/arm/plat-s3c24xx/devs.c     |    1 -
 arch/arm/plat-samsung/dev-nand.c |    2 --
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
index 2f91057..10ce666 100644
--- a/arch/arm/plat-s3c24xx/devs.c
+++ b/arch/arm/plat-s3c24xx/devs.c
@@ -194,7 +194,6 @@ void __init s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *hard_s3c2410ts_
 	memcpy(&s3c2410ts_info, hard_s3c2410ts_info, sizeof(struct s3c2410_ts_mach_info));
 	s3c_device_ts.dev.platform_data = &s3c2410ts_info;
 }
-EXPORT_SYMBOL(s3c24xx_ts_set_platdata);
 
 /* USB Device (Gadget)*/
 
diff --git a/arch/arm/plat-samsung/dev-nand.c b/arch/arm/plat-samsung/dev-nand.c
index 3a7b889..6927ae8 100644
--- a/arch/arm/plat-samsung/dev-nand.c
+++ b/arch/arm/plat-samsung/dev-nand.c
@@ -126,5 +126,3 @@ void __init s3c_nand_set_platdata(struct s3c2410_platform_nand *nand)
 
 	s3c_device_nand.dev.platform_data = npd;
 }
-
-EXPORT_SYMBOL_GPL(s3c_nand_set_platdata);
-- 
1.7.2.3
