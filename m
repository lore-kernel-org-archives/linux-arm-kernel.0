From: jonathan.austin@arm.com (Jonathan Austin)
Date: Fri,  7 Jun 2013 18:17:53 +0100
Subject: [PATCH] ARM: mpu: Ensure that MPU depends on CPU_V7
Message-ID: <1370625473-21628-1-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The support for the MPU is currently implemented only for R-class
(PMSAv7/R). Since the merge of V7M support in to the kernel it is possible
to select MPU support on V7M.

This patch ensures that until MPU support for M-class processors is
implemented, the MPU can only be selected with R-class CPUs

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Cc: Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
---

This patch is necessary now that Russell has merged the V7M work in to his
devel-stable branch.

I don't have any immediate plans to implement MPU support for M-class, so this
patch is important to ensure we don't break building of V7M platforms.

 arch/arm/Kconfig-nommu |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig-nommu b/arch/arm/Kconfig-nommu
index db597e1..aed66d5 100644
--- a/arch/arm/Kconfig-nommu
+++ b/arch/arm/Kconfig-nommu
@@ -53,6 +53,7 @@ config REMAP_VECTORS_TO_RAM
 
 config ARM_MPU
        bool 'Use the ARM v7 PMSA Compliant MPU'
+       depends on CPU_V7
        default y
        help
          Some ARM systems without an MMU have instead a Memory Protection
-- 
1.7.9.5
