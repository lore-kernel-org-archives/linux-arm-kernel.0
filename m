From: ulfalizer@gmail.com (Ulf Magnusson)
Date: Mon,  5 Feb 2018 02:21:24 +0100
Subject: [PATCH 12/20] ARM: debug: Remove ARCH_MSM dep. from UNCOMPRESS_INCLUDE
In-Reply-To: <20180205012146.23981-1-ulfalizer@gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com>
Message-ID: <20180205012146.23981-13-ulfalizer@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARCH_MSM symbol was removed in commit c0c89fafa289 ("ARM: Remove
mach-msm and associated ARM architecture code"), but a default in
UNCOMPRESS_INCLUDE still depends on it.

Remove the ARCH_MSM dependency from the default in UNCOMPRESS_INCLUDE.

Discovered with the
https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
script.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 arch/arm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 78a647080ebc..20c601a045d2 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1825,7 +1825,7 @@ config DEBUG_UNCOMPRESS
 
 config UNCOMPRESS_INCLUDE
 	string
-	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM || \
+	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || \
 					PLAT_SAMSUNG || ARM_SINGLE_ARMV7M
 	default "mach/uncompress.h"
 
-- 
2.14.1
