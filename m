From: panchaxari.prasannamurthy@linaro.org (panchaxari)
Date: Wed, 27 Nov 2013 09:58:05 +0530
Subject: [PATCH] ARM:EXYNOS:Enable ARM_PATCH_PHYS_VIRT and AUTO_ZRELADDR by
 default
In-Reply-To: <1385526485-23758-1-git-send-email-panchaxari.prasannamurthy@linaro.org>
References: <1385526485-23758-1-git-send-email-panchaxari.prasannamurthy@linaro.org>
Message-ID: <1385526485-23758-2-git-send-email-panchaxari.prasannamurthy@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM_PATCH_PHYS_VIRT and AUTO_ZRELADDR is enabled by default for Exynos
platforms.

Introduction of this config as default will enable phy-to-virt and
virt-to-phy translation function at boot and module loading time
and enforce dynamic reallocation of memory.

This config is mutually exclusive to XIP_KERNEL, which is used in
systems with NOR flash devices

Requesting Exynos maintainers to evaluate the changes on the
board and comment, as I dont have the board for testing
I am seeking an ACK from Exynos maintainers.

Signed-off-by: panchaxari <panchaxari.prasannamurthy@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
---
 arch/arm/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 214b698..28d84f3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -807,6 +807,8 @@ config ARCH_EXYNOS
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_SPARSEMEM_ENABLE
 	select ARM_GIC
+	select ARM_PATCH_PHYS_VIRT
+	select AUTO_ZRELADDR
 	select COMMON_CLK
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
-- 
1.7.10.4
