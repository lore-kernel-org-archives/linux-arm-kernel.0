From: netz.kernel@gmail.com (Marty Plummer)
Date: Thu,  8 Sep 2016 12:23:40 -0500
Subject: [RFC 1/7] Make Hi3620 explicit, remove wildcards
Message-ID: <20160908172346.27506-1-netz.kernel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a preparatory series for adding the ARMv5/v6 hi3520 SoCs.
Assumptions were made when adding hi3620 that don't hold water in
light of adding support for the hi3520 SoC.  Fix the issue by renaming
config options and other namespaces to avoid collisions with the new
work.

Only internal APIs are modified with this series.

Signed-off-by: Marty Plummer <netz.kernel@gmail.com>
---
 arch/arm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index a9693b6..9094ca6 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -280,7 +280,7 @@ choice
 
 	config DEBUG_HI3620_UART
 		bool "Hisilicon HI3620 Debug UART"
-		depends on ARCH_HI3xxx
+		depends on ARCH_HI3620
 		select DEBUG_UART_PL01X
 		help
 		  Say Y here if you want kernel low-level debugging support
-- 
2.9.3
