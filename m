From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue,  8 Apr 2014 16:00:42 +0800
Subject: [PATCH v2 02/12] ARM: append ARCH_MULTI_V7_LPAE
In-Reply-To: <1396944052-9887-1-git-send-email-haojian.zhuang@linaro.org>
References: <1396944052-9887-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1396944052-9887-3-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new ARCH_MULTI_V7_LPAE config. It will select ARM_LPAE only both
ARCH_MULTI_V6 & ARCH_MULTI_V7 is disabled.

ARCH_MULTI_V7 means non-LPAE platform.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/Kconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5248923..a8b2b45 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -918,12 +918,19 @@ config ARCH_MULTI_V6
 	select CPU_V6K
 
 config ARCH_MULTI_V7
-	bool "ARMv7 based platforms (Cortex-A, PJ4, Scorpion, Krait)"
+	bool "ARMv7 non-LPAE based platforms (Cortex-A, PJ4, Scorpion, Krait)"
 	default y
 	select ARCH_MULTI_V6_V7
 	select CPU_V7
 	select HAVE_SMP
 
+config ARCH_MULTI_V7_LPAE
+	bool "ARMv7 LPAE based platforms (HIP04)"
+	select ARCH_MULTI_V6_V7
+	select CPU_V7
+	select HAVE_SMP
+	select ARM_LPAE if !(ARCH_MULTI_V6 || ARCH_MULTI_V7)
+
 config ARCH_MULTI_V6_V7
 	bool
 	select MIGHT_HAVE_CACHE_L2X0
-- 
1.8.3.2
