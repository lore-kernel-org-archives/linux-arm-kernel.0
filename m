From: afzal@ti.com (Afzal Mohammed)
Date: Fri, 19 Oct 2012 15:29:43 +0530
Subject: [PATCH v4 4/5] rtc: omap: depend on am33xx
In-Reply-To: <cover.1350633036.git.afzal@ti.com>
References: <cover.1350633036.git.afzal@ti.com>
Message-ID: <461eeca5902e383a3d26149700cde751d5450951.1350633036.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rtc-omap driver can be reused for AM33xx RTC.
Provide dependency in Kconfig.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Acked-by: Sekhar Nori <nsekhar@ti.com>
---

v2:
 Modify Kconfig help, resolve checkpatch warning

 drivers/rtc/Kconfig | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 19c03ab..4f7ecb6 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -777,11 +777,13 @@ config RTC_DRV_IMXDI
 
 config RTC_DRV_OMAP
 	tristate "TI OMAP1"
-	depends on ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_DAVINCI_DA8XX
+	depends on ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_DAVINCI_DA8XX || SOC_AM33XX
 	help
-	  Say "yes" here to support the real time clock on TI OMAP1 and
-	  DA8xx/OMAP-L13x chips.  This driver can also be built as a
-	  module called rtc-omap.
+	  Say "yes" here to support the on chip real time clock
+	  present on TI OMAP1, AM33xx and DA8xx/OMAP-L13x.
+
+	  This driver can also be built as a module, if so, module
+	  will be called rtc-omap.
 
 config HAVE_S3C_RTC
 	bool
-- 
1.7.12
