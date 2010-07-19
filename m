From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 19 Jul 2010 12:58:58 +0200
Subject: [PATCH 3/9] [ARM] pxa: use generic gpio_get_value() instead of
	READ_GPIO_BIT()
In-Reply-To: <1279537144-25424-1-git-send-email-eric.y.miao@gmail.com>
References: <1279537144-25424-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1279537144-25424-3-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

READ_GPIO_BIT() is no way generic by accessing GPIO registers directly,
replace it with gpio_get_value().

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/corgi_pm.c |    6 +++---
 arch/arm/mach-pxa/spitz_pm.c |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-pxa/corgi_pm.c b/arch/arm/mach-pxa/corgi_pm.c
index a735205..41cf945 100644
--- a/arch/arm/mach-pxa/corgi_pm.c
+++ b/arch/arm/mach-pxa/corgi_pm.c
@@ -134,11 +134,11 @@ unsigned long corgipm_read_devdata(int type)
 	case SHARPSL_STATUS_ACIN:
 		return ((GPLR(CORGI_GPIO_AC_IN) & GPIO_bit(CORGI_GPIO_AC_IN)) != 0);
 	case SHARPSL_STATUS_LOCK:
-		return READ_GPIO_BIT(sharpsl_pm.machinfo->gpio_batlock);
+		return gpio_get_value(sharpsl_pm.machinfo->gpio_batlock);
 	case SHARPSL_STATUS_CHRGFULL:
-		return READ_GPIO_BIT(sharpsl_pm.machinfo->gpio_batfull);
+		return gpio_get_value(sharpsl_pm.machinfo->gpio_batfull);
 	case SHARPSL_STATUS_FATAL:
-		return READ_GPIO_BIT(sharpsl_pm.machinfo->gpio_fatal);
+		return gpio_get_value(sharpsl_pm.machinfo->gpio_fatal);
 	case SHARPSL_ACIN_VOLT:
 		return sharpsl_pm_pxa_read_max1111(MAX1111_ACIN_VOLT);
 	case SHARPSL_BATT_TEMP:
diff --git a/arch/arm/mach-pxa/spitz_pm.c b/arch/arm/mach-pxa/spitz_pm.c
index b36f0ae..53103d3 100644
--- a/arch/arm/mach-pxa/spitz_pm.c
+++ b/arch/arm/mach-pxa/spitz_pm.c
@@ -178,11 +178,11 @@ unsigned long spitzpm_read_devdata(int type)
 	case SHARPSL_STATUS_ACIN:
 		return (((~GPLR(SPITZ_GPIO_AC_IN)) & GPIO_bit(SPITZ_GPIO_AC_IN)) != 0);
 	case SHARPSL_STATUS_LOCK:
-		return READ_GPIO_BIT(sharpsl_pm.machinfo->gpio_batlock);
+		return gpio_get_value(sharpsl_pm.machinfo->gpio_batlock);
 	case SHARPSL_STATUS_CHRGFULL:
-		return READ_GPIO_BIT(sharpsl_pm.machinfo->gpio_batfull);
+		return gpio_get_value(sharpsl_pm.machinfo->gpio_batfull);
 	case SHARPSL_STATUS_FATAL:
-		return READ_GPIO_BIT(sharpsl_pm.machinfo->gpio_fatal);
+		return gpio_get_value(sharpsl_pm.machinfo->gpio_fatal);
 	case SHARPSL_ACIN_VOLT:
 		return sharpsl_pm_pxa_read_max1111(MAX1111_ACIN_VOLT);
 	case SHARPSL_BATT_TEMP:
-- 
1.7.1
