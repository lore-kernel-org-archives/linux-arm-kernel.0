From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 13 Jun 2017 10:05:04 +0100
Subject: [PATCH 4/7] ARM: NOMMU: Disallow MPU for XIP
In-Reply-To: <1497344707-14446-1-git-send-email-vladimir.murzin@arm.com>
References: <1497344707-14446-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1497344707-14446-5-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It seems that MPU never worked with XIP, so we just disallow such
combination.

Tested-by: Szemz? Andr?s <sza@esh.hu>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/Kconfig-nommu | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig-nommu b/arch/arm/Kconfig-nommu
index b757634..6d18395 100644
--- a/arch/arm/Kconfig-nommu
+++ b/arch/arm/Kconfig-nommu
@@ -52,7 +52,7 @@ config REMAP_VECTORS_TO_RAM
 
 config ARM_MPU
        bool 'Use the ARM v7 PMSA Compliant MPU'
-       depends on CPU_V7
+       depends on !XIP_KERNEL && CPU_V7
        default y
        help
          Some ARM systems without an MMU have instead a Memory Protection
-- 
2.0.0
