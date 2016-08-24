From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 24 Aug 2016 15:29:02 +0200
Subject: [PATCH 10/10] reset: hi6220: allow to compile test driver on other
 architectures
In-Reply-To: <1472045342-7434-1-git-send-email-p.zabel@pengutronix.de>
References: <1472045342-7434-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1472045342-7434-10-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also remove the RESET_CONTROLLER dependency, this Kconfig file is
included inside the menuconfig already.

Cc: Chen Feng <puck.chen@hisilicon.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/hisilicon/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/hisilicon/Kconfig b/drivers/reset/hisilicon/Kconfig
index 26bf95a..1ff8b0c 100644
--- a/drivers/reset/hisilicon/Kconfig
+++ b/drivers/reset/hisilicon/Kconfig
@@ -1,5 +1,6 @@
 config COMMON_RESET_HI6220
 	tristate "Hi6220 Reset Driver"
-	depends on (ARCH_HISI && RESET_CONTROLLER)
+	depends on ARCH_HISI || COMPILE_TEST
+	default ARCH_HISI
 	help
 	  Build the Hisilicon Hi6220 reset driver.
-- 
2.8.1
