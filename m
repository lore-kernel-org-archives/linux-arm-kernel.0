From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 16 Aug 2016 18:19:22 +0900
Subject: [PATCH] arm64: remove redundant "select HAVE_CLK"
Message-ID: <1471339162-29585-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HAVE_CLK is select'ed by CLKDEV_LOOKUP, which is select'ed by
COMMON_CLK, which is select'ed by ARM64.  No sub-architecture
need to select HAVE_CLK explicitly.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/Kconfig.platforms | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index be5d824..4a4318b 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -159,7 +159,6 @@ config ARCH_TEGRA
 	select CLKSRC_MMIO
 	select CLKSRC_OF
 	select GENERIC_CLOCKEVENTS
-	select HAVE_CLK
 	select PINCTRL
 	select RESET_CONTROLLER
 	help
-- 
1.9.1
