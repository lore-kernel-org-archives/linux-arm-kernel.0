From: jiri.pinkava@vscht.cz (jiri.pinkava at vscht.cz)
Date: Wed, 6 Apr 2011 01:06:06 +0200
Subject: [PATCH 4/6] n30: Fix MMC power management
In-Reply-To: <1302044768-7774-1-git-send-email-jiri.pinkava@vscht.cz>
References: <1302044768-7774-1-git-send-email-jiri.pinkava@vscht.cz>
Message-ID: <1302044768-7774-5-git-send-email-jiri.pinkava@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiri Pinkava <jiri.pinkava@vscht.cz>

On/off states were swapped. In off state voltage just drops low,
card still behaves like powered, but causes serious filesystem 
corruptions during writing.

Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
---
 arch/arm/mach-s3c2410/mach-n30.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-n30.c b/arch/arm/mach-s3c2410/mach-n30.c
index d98d7b5..6396827 100644
--- a/arch/arm/mach-s3c2410/mach-n30.c
+++ b/arch/arm/mach-s3c2410/mach-n30.c
@@ -350,11 +350,11 @@ static void n30_sdi_set_power(unsigned char power_mode, unsigned short vdd)
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
1.7.4.2
