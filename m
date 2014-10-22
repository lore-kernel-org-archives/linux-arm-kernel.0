From: yingjoe.chen@mediatek.com (Joe.C)
Date: Wed, 22 Oct 2014 18:29:57 +0800
Subject: [PATCH v4 8/8] ARM: mediatek: Add config option for mediatek SoCs.
In-Reply-To: <1413973797-17619-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1413973797-17619-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1413973797-17619-9-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Joe.C" <yingjoe.chen@mediatek.com>

Add config options for ARCH_MT6589, ARCH_MT8127, ARCH_MT8135. The
upcoming pinctrl, clk drivers need to isolate SoCs support base on
these options.

Signed-off-by: Joe.C <yingjoe.chen@mediatek.com>
---
 arch/arm/mach-mediatek/Kconfig | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 2c043a2..25fe6cf 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -1,6 +1,22 @@
-config ARCH_MEDIATEK
-	bool "Mediatek MT6589 SoC" if ARCH_MULTI_V7
+menuconfig ARCH_MEDIATEK
+	bool "Mediatek MT65xx & MT81xx SoC" if ARCH_MULTI_V7
 	select ARM_GIC
 	select MTK_TIMER
 	help
-	  Support for Mediatek Cortex-A7 Quad-Core-SoC MT6589.
+	  Support for Mediatek MT65xx & MT81xx SoCs
+
+if ARCH_MEDIATEK
+
+config MACH_MT6589
+	bool "MediaTek MT6589 SoCs support"
+	default ARCH_MEDIATEK
+
+config MACH_MT8127
+	bool "MediaTek MT8127 SoCs support"
+	default ARCH_MEDIATEK
+
+config MACH_MT8135
+	bool "MediaTek MT8135 SoCs support"
+	default ARCH_MEDIATEK
+
+endif
-- 
1.8.1.1.dirty
