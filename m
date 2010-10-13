From: Jiri.Pinkava@vscht.cz (Jiri.Pinkava at vscht.cz)
Date: Wed, 13 Oct 2010 09:56:20 +0200
Subject: [PATCH 4/6] n30: Fix MMC power management on Acer n30 / n35
In-Reply-To: <4CA91E6F.3010704@vscht.cz>
References: <4CA91E6F.3010704@vscht.cz>
Message-ID: <1286956582-15586-4-git-send-email-jiri.pinkava@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Someone (me) messed this up. MMC works even in off state, but causes serious
data corruptions during write.


Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
---
 arch/arm/mach-s3c2410/mach-n30.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-n30.c b/arch/arm/mach-s3c2410/mach-n30.c
index 895e1e9a..ecc039a 100644
--- a/arch/arm/mach-s3c2410/mach-n30.c
+++ b/arch/arm/mach-s3c2410/mach-n30.c
@@ -366,11 +366,11 @@ static void n30_sdi_set_power(unsigned char power_mode, unsigned short vdd)
 	switch (power_mode) {
 	case MMC_POWER_ON:
 	case MMC_POWER_UP:
-		gpio_set_value(S3C2410_GPG(4), 1);
+		gpio_set_value(S3C2410_GPG(4), 0);
 		break;
 	case MMC_POWER_OFF:
 	default:
-		gpio_set_value(S3C2410_GPG(4), 0);
+		gpio_set_value(S3C2410_GPG(4), 1);
 		break;
 	}
 }
-- 
1.7.3.1
