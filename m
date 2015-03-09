From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Mon, 9 Mar 2015 16:13:44 +0800
Subject: [PATCH] pinctrl: mediatek: Adjust mt8173 pinctrl kconfig
In-Reply-To: <1425623091-30478-2-git-send-email-yingjoe.chen@mediatek.com>
References: <1425623091-30478-2-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1425888824-13935-1-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change based on Paul's suggestion.
Old patch can be found at:
http://lists.infradead.org/pipermail/linux-mediatek/2015-March/000057.html

------
ARM64 maintainer doesn't want to add MACH_* for each SoC.
Adjust mt8173 pinctrl kconfig entry so user can manually select it.

Also make PINCTRL_MT8135 build when COMPILE_TEST is enabled.

Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 drivers/pinctrl/mediatek/Kconfig | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 49b8649..0e3a002 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -1,4 +1,4 @@
-if ARCH_MEDIATEK
+if ARCH_MEDIATEK || COMPILE_TEST
 
 config PINCTRL_MTK_COMMON
 	bool
@@ -8,11 +8,13 @@ config PINCTRL_MTK_COMMON
 	select OF_GPIO
 
 config PINCTRL_MT8135
-	def_bool MACH_MT8135
+	def_bool MACH_MT8135 || COMPILE_TEST
 	select PINCTRL_MTK_COMMON
 
 config PINCTRL_MT8173
-	def_bool MACH_MT8173
+	bool "Mediatek MT8173 pin control"
+	default y
+	depends on ARM64 || COMPILE_TEST
 	select PINCTRL_MTK_COMMON
 
 endif
-- 
1.8.1.1.dirty
