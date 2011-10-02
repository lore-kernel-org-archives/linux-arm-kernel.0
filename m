From: arnd@arndb.de (Arnd Bergmann)
Date: Sun,  2 Oct 2011 16:45:58 +0200
Subject: [PATCH 28/30] ARM: omap: select CPU_FREQ_TABLE where needed
In-Reply-To: <1317566760-25681-1-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Message-ID: <1317566760-25681-29-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The omap platform requires CPU_FREQ_TABLE support to be enabled for its
CPU_FREQ implementations, so automatically select that when CPU_FREQ
is enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/plat-omap/Kconfig |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index bb8f4a6..f7ef9f4 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -217,6 +217,11 @@ config OMAP_PM_NOOP
 
 endchoice
 
+config OMAP_CPU_FREQ
+	def_bool "y"
+	depends on CPU_FREQ
+	select CPU_FREQ_TABLE
+
 endmenu
 
 endif
-- 
1.7.5.4
