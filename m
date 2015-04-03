From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 03 Apr 2015 11:54:42 +0100
Subject: [PATCH 6/7] ARM: enable ARM errata 643719 workaround by default
In-Reply-To: <20150403100848.GZ24899@n2100.arm.linux.org.uk>
References: <20150403100848.GZ24899@n2100.arm.linux.org.uk>
Message-ID: <E1YdzFK-0008Cz-SY@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The effects of not having ARM errata 643719 enabled on affected CPUs
can be very confusing and hard to debug.  Rather than leave this to
chance, enable this workaround by default.  Now that we have rearranged
the code, it should have a low impact on the majority of CPUs.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2eb6de9465bf..c26dfef393cd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1139,6 +1139,7 @@ config ARM_ERRATA_742231
 config ARM_ERRATA_643719
 	bool "ARM errata: LoUIS bit field in CLIDR register is incorrect"
 	depends on CPU_V7 && SMP
+	default y
 	help
 	  This option enables the workaround for the 643719 Cortex-A9 (prior to
 	  r1p0) erratum. On affected cores the LoUIS bit field of the CLIDR
-- 
1.8.3.1
