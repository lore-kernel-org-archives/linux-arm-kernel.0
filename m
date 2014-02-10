From: jg1.han@samsung.com (Jingoo Han)
Date: Mon, 10 Feb 2014 10:10:56 +0900
Subject: [PATCH 3/7] ARM: remove HAVE_PWM config option
In-Reply-To: <003901cf25fc$73002790$590076b0$%han@samsung.com>
References: <003901cf25fc$73002790$590076b0$%han@samsung.com>
Message-ID: <003c01cf25fc$f3a707b0$daf51710$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HAVE_PWM symbol is only for legacy platforms that provide
the PWM API without using the generic framework. However, legacy
PWM drivers for ARM platforms were already moved to the generic
PWM framework. Thus, HAVE_PWM should be removed, because HAVE_PWM
is not required anymore.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 arch/arm/Kconfig |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 897fa15..cc6ce44 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -113,9 +113,6 @@ config ARM_DMA_IOMMU_ALIGNMENT
 
 endif
 
-config HAVE_PWM
-	bool
-
 config MIGHT_HAVE_PCI
 	bool
 
-- 
1.7.10.4
