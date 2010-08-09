From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Mon,  9 Aug 2010 09:17:30 -0700
Subject: [PATCH 2/2] rtc: Add support in Makefile/Kconfig for the LPC32XX RTC
In-Reply-To: <1281370650-29520-1-git-send-email-wellsk40@gmail.com>
References: <1281370650-29520-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1281370650-29520-3-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Enable build RTC support for the LPC32XX in makefile/Kconfig

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
Signed-off-by: Durgesh Pattamatta <durgesh.pattamatta@nxp.com>
---
 drivers/rtc/Kconfig  |    9 +++++++++
 drivers/rtc/Makefile |    1 +
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 4301a6c..8452788 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -916,4 +916,13 @@ config RTC_DRV_JZ4740
 	  This driver can also be buillt as a module. If so, the module
 	  will be called rtc-jz4740.
 
+config RTC_DRV_LPC32XX
+        depends on ARCH_LPC32XX
+        tristate "NXP LPC32XX RTC"
+        help
+          This enables support for the NXP RTC in the LPC32XX
+
+	  This driver can also be buillt as a module. If so, the module
+	  will be called rtc-lpc32xx.
+
 endif # RTC_CLASS
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index fedf9bb..3b8af95 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_RTC_DRV_FM3130)	+= rtc-fm3130.o
 obj-$(CONFIG_RTC_DRV_GENERIC)	+= rtc-generic.o
 obj-$(CONFIG_RTC_DRV_ISL1208)	+= rtc-isl1208.o
 obj-$(CONFIG_RTC_DRV_JZ4740)	+= rtc-jz4740.o
+obj-$(CONFIG_RTC_DRV_LPC32XX)   += rtc-lpc32xx.o
 obj-$(CONFIG_RTC_DRV_M41T80)	+= rtc-m41t80.o
 obj-$(CONFIG_RTC_DRV_M41T94)	+= rtc-m41t94.o
 obj-$(CONFIG_RTC_DRV_M48T35)	+= rtc-m48t35.o
-- 
1.7.1.1
