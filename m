From: Jiri.Pinkava@vscht.cz (=?ISO-8859-2?Q?Ji=F8=ED_Pinkava?=)
Date: Mon, 4 Oct 2010 02:29:43 +0200
Subject: [PATCH 4/6] n30: Fix MMC power management
In-Reply-To: <4CA91F4F.8080204@vscht.cz>
References: <4CA91E6F.3010704@vscht.cz> <4CA91EDA.80009@vscht.cz>
	<4CA91F05.3040602@vscht.cz> <4CA91F4F.8080204@vscht.cz>
Message-ID: <4CA91FF7.7020908@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MMC "works" in both on or off state, but when operate in off causes 
serious data corruptions.


Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
---
  arch/arm/mach-s3c2410/mach-n30.c |    4 ++--
  1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-n30.c 
b/arch/arm/mach-s3c2410/mach-n30.c
index 895e1e9a..ecc039a 100644
--- a/arch/arm/mach-s3c2410/mach-n30.c
+++ b/arch/arm/mach-s3c2410/mach-n30.c
@@ -366,11 +366,11 @@ static void n30_sdi_set_power(unsigned char 
power_mode, unsigned short vdd)
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
