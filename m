From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:51:13 +0200
Subject: [PATCH 37/40] ARM: mx51: Add audmux support
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-37-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx5/Kconfig     |    1 +
 arch/arm/plat-mxc/audmux-v2.c |    8 +++++++-
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 65bf34e..3a4c3b3 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -5,6 +5,7 @@ config ARCH_MX51
 	default y
 	select MXC_TZIC
 	select ARCH_MXC_IOMUX_V3
+	select ARCH_MXC_AUDMUX_V2
 
 comment "MX5 platforms:"
 
diff --git a/arch/arm/plat-mxc/audmux-v2.c b/arch/arm/plat-mxc/audmux-v2.c
index f9e7cdb..6292049 100644
--- a/arch/arm/plat-mxc/audmux-v2.c
+++ b/arch/arm/plat-mxc/audmux-v2.c
@@ -186,7 +186,13 @@ EXPORT_SYMBOL_GPL(mxc_audmux_v2_configure_port);
 static int mxc_audmux_v2_init(void)
 {
 	int ret;
-
+#if defined(CONFIG_ARCH_MX5)
+	if (cpu_is_mx51()) {
+		audmux_base = MX51_IO_ADDRESS(MX51_AUDMUX_BASE_ADDR);
+		ret = 0;
+		return ret;
+	}
+#endif
 #if defined(CONFIG_ARCH_MX3)
 	if (cpu_is_mx31())
 		audmux_base = MX31_IO_ADDRESS(MX31_AUDMUX_BASE_ADDR);
-- 
1.7.2.3
