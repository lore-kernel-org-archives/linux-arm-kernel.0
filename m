From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu,  1 Nov 2012 07:04:13 +0800
Subject: [PATCH v3 1/9] ARM: mmp: select pinctrl driver
In-Reply-To: <1351724661-29050-1-git-send-email-haojian.zhuang@gmail.com>
References: <1351724661-29050-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1351724661-29050-2-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pinctrl driver is necessary for MMP DT & MMP2 DT platforms.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-mmp/Kconfig |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index 178d4da..ebdda83 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -89,6 +89,8 @@ config MACH_MMP_DT
 	select CPU_PXA168
 	select CPU_PXA910
 	select USE_OF
+	select PINCTRL
+	select PINCTRL_SINGLE
 	help
 	  Include support for Marvell MMP2 based platforms using
 	  the device tree. Needn't select any other machine while
@@ -99,6 +101,8 @@ config MACH_MMP2_DT
 	depends on !CPU_MOHAWK
 	select CPU_MMP2
 	select USE_OF
+	select PINCTRL
+	select PINCTRL_SINGLE
 	help
 	  Include support for Marvell MMP2 based platforms using
 	  the device tree.
-- 
1.7.10.4
