From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 13 Dec 2011 17:56:33 +0000
Subject: [PATCH v4 5/5] imx6q: Remove unconditional dependency on l2x0 L2
 cache support
In-Reply-To: <1323798993-8727-1-git-send-email-dave.martin@linaro.org>
References: <1323798993-8727-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1323798993-8727-6-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX6 Quad SoC will work without the l2x0 L2 cache controller
support built into the kernel, so this patch removes the dependency
on CACHE_L2X0 and selects MIGHT_HAVE_CACHE_L2X0 instead.

This makes the l2x0 support optional, so that it can be turned off
when desired for debugging purposes etc.

Thanks to Shawn Guo for this suggestion. [1]

Signed-off-by: Dave Martin <dave.martin@linaro.org>

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074602.html
---
 arch/arm/mach-imx/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 29a3d61..1fb93f2 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -609,13 +609,13 @@ comment "i.MX6 family:"
 config SOC_IMX6Q
 	bool "i.MX6 Quad support"
 	select ARM_GIC
-	select CACHE_L2X0
 	select CPU_V7
 	select HAVE_ARM_SCU
 	select HAVE_IMX_GPC
 	select HAVE_IMX_MMDC
 	select HAVE_IMX_SRC
 	select HAVE_SMP
+	select MIGHT_HAVE_CACHE_L2X0
 	select USE_OF
 
 	help
-- 
1.7.4.1
