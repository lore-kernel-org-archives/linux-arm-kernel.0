From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 20 Mar 2014 13:55:23 +0900
Subject: [PATCH v3 2/4] ARM: select COMMON_CLK_SAMSUNG for ARCH_EXYNOS and
 ARCH_S3C64XX
In-Reply-To: <1395291325-4043-1-git-send-email-pankaj.dubey@samsung.com>
References: <1394598781-3848-1-git-send-email-pankaj.dubey@samsung.com>
 <1395291325-4043-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1395291325-4043-3-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch selects COMMON_CLK_SAMSUNG for EXYNOS and S3C64XX SoC
and removes COMMON_CLK selection as COMMON_CLK_SAMSUNG selects it's dependency.

CC: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e254198..0c15aa7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -755,7 +755,7 @@ config ARCH_S3C64XX
 	select ARM_VIC
 	select CLKDEV_LOOKUP
 	select CLKSRC_SAMSUNG_PWM
-	select COMMON_CLK
+	select COMMON_CLK_SAMSUNG
 	select CPU_V6K
 	select GENERIC_CLOCKEVENTS
 	select GPIO_SAMSUNG
@@ -834,7 +834,7 @@ config ARCH_EXYNOS
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_SPARSEMEM_ENABLE
 	select ARM_GIC
-	select COMMON_CLK
+	select COMMON_CLK_SAMSUNG
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
 	select HAVE_S3C2410_I2C if I2C
-- 
1.7.10.4
