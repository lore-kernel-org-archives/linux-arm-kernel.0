From: stefan@agner.ch (Stefan Agner)
Date: Sat, 11 Aug 2018 12:31:27 +0200
Subject: [PATCH] ARM: drop experimental mark for ARM stack unwinding
Message-ID: <20180811103127.21485-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM stack unwinding is upstream since 2009 and has been proven
working well. At this time it is the preferred stack unwinding
support since it also supports Thumb 2. Do not scare people
and drop the EXPERIMENTAL mark.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index cb65cf67dfa2..ba2d94555e06 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -63,7 +63,7 @@ config FRAME_POINTER
 	  reported is severely limited.
 
 config ARM_UNWIND
-	bool "Enable stack unwinding support (EXPERIMENTAL)"
+	bool "Enable stack unwinding support"
 	depends on AEABI
 	default y
 	help
-- 
2.18.0
