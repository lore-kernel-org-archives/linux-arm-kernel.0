From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Thu, 29 Sep 2016 18:31:50 +0200
Subject: [PATCH 1/6] ARM: davinci: da8xx-dt: add OF_DEV_AUXDATA entry for lcdc
In-Reply-To: <1475166715-7857-1-git-send-email-bgolaszewski@baylibre.com>
References: <1475166715-7857-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1475166715-7857-2-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Karl Beldan <kbeldan@baylibre.com>

This is required for tilcdc to be able to acquire a functional clock.

Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
[Bartosz: added the commit description]
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da8xx-dt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index c9f7e92..f8ecc02 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -38,6 +38,7 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 		       NULL),
 	OF_DEV_AUXDATA("ti,da830-mcasp-audio", 0x01d00000, "davinci-mcasp.0", NULL),
 	OF_DEV_AUXDATA("ti,da850-aemif", 0x68000000, "ti-aemif", NULL),
+	OF_DEV_AUXDATA("ti,am33xx-tilcdc", 0x01e13000, "da8xx_lcdc.0", NULL),
 	{}
 };
 
-- 
2.7.4
