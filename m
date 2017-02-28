From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 28 Feb 2017 07:35:17 +0100
Subject: [PATCH v3 07/25] ARM64: Prepare Actions Semi S900
In-Reply-To: <20170228063535.32069-1-afaerber@suse.de>
References: <20170228063535.32069-1-afaerber@suse.de>
Message-ID: <20170228063535.32069-8-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ARCH_ACTIONS.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2 -> v3:
 * Selected clocksource driver
 
 v1 -> v2:
 * Renamed ARCH_OWL to ARCH_ACTION (Arnd)
 
 arch/arm64/Kconfig.platforms | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 129cc5a..761b31f 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -1,5 +1,11 @@
 menu "Platform selection"
 
+config ARCH_ACTIONS
+	bool "Actions Semi Platforms"
+	select OWL_TIMER
+	help
+	  This enables support for the Actions Semiconductor S900 SoC family.
+
 config ARCH_SUNXI
 	bool "Allwinner sunxi 64-bit SoC Family"
 	select GENERIC_IRQ_CHIP
-- 
2.10.2
