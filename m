From: ciminaghi@gnudd.com (Davide Ciminaghi)
Date: Mon, 10 Dec 2012 14:42:32 +0100
Subject: [PATCH v4 3/7] watchdog: sp805_wdt depends on ARM
In-Reply-To: <1355146956-6009-1-git-send-email-ciminaghi@gnudd.com>
References: <1355146956-6009-1-git-send-email-ciminaghi@gnudd.com>
Message-ID: <1355146956-6009-4-git-send-email-ciminaghi@gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alessandro Rubini <rubini@gnudd.com>

The SP805 driver is only used by the Spear machines, and uses
writel_relaxed, which is not available on all architectures.

The dependency from CONFIG_ARM avoids compilation problems under
randomconfig when CONFIG_ARM_AMBA is enabled for x86 builds.

Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
Signed-off-by: Davide Ciminaghi <ciminaghi@gnudd.com>
---
 drivers/watchdog/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index ad1bb93..c76fc07 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -98,7 +98,7 @@ config WM8350_WATCHDOG
 
 config ARM_SP805_WATCHDOG
 	tristate "ARM SP805 Watchdog"
-	depends on ARM_AMBA
+	depends on ARM && ARM_AMBA
 	select WATCHDOG_CORE
 	help
 	  ARM Primecell SP805 Watchdog timer. This will reboot your system when
-- 
1.7.10.4
