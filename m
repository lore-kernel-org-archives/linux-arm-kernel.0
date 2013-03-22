From: ian@slimlogic.co.uk (Ian Lartey)
Date: Fri, 22 Mar 2013 14:55:15 +0000
Subject: [PATCH v10 05/12] watchdog: Kconfig for Palmas watchdog
In-Reply-To: <1363964122-19201-1-git-send-email-ian@slimlogic.co.uk>
References: <1363964122-19201-1-git-send-email-ian@slimlogic.co.uk>
Message-ID: <1363964122-19201-6-git-send-email-ian@slimlogic.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the Kconfig and Makefile for the Palmas watchdog driver

Signed-off-by: Ian Lartey <ian@slimlogic.co.uk>
Signed-off-by: Graeme Gregory <gg@slimlogic.co.uk>
---
 drivers/watchdog/Kconfig  |    8 ++++++++
 drivers/watchdog/Makefile |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 9fcc70c..d48cb0e 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -103,6 +103,14 @@ config WM8350_WATCHDOG
 	  Support for the watchdog in the WM8350 AudioPlus PMIC.  When
 	  the watchdog triggers the system will be reset.
 
+config PALMAS_WATCHDOG
+	tristate "Palmas Watchdog"
+	depends on MFD_PALMAS
+	select WATCHDOG_CORE
+	help
+	  Support for the watchdog in the Palmas family of PMICs. When the
+	  watchdog times out system will be reset.
+
 # ALPHA Architecture
 
 # ARM Architecture
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index a300b94..e845c21 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -171,3 +171,4 @@ obj-$(CONFIG_WM831X_WATCHDOG) += wm831x_wdt.o
 obj-$(CONFIG_WM8350_WATCHDOG) += wm8350_wdt.o
 obj-$(CONFIG_MAX63XX_WATCHDOG) += max63xx_wdt.o
 obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
+obj-$(CONFIG_PALMAS_WATCHDOG) += palmas_wdt.o
-- 
1.7.0.4
