From: dciminaghi@mail.gnudd.com (Davide Ciminaghi)
Date: Fri, 14 Sep 2012 18:23:59 +0200
Subject: [PATCH 4/8] watchdog: sp805_wdt depends on ARM
In-Reply-To: <1347639843-32119-1-git-send-email-dciminaghi@mail.gnudd.com>
References: <1347639843-32119-1-git-send-email-dciminaghi@mail.gnudd.com>
Message-ID: <1347639843-32119-5-git-send-email-dciminaghi@mail.gnudd.com>
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
 1 files changed, 1 insertions(+), 1 deletions(-)

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
1.7.9.1
