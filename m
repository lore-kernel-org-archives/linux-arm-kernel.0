From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 25 Jun 2018 12:34:45 +0900
Subject: [PATCH 2/2] arm64: uniphier: select RESET_CONTROLLER
In-Reply-To: <1529897685-15029-1-git-send-email-yamada.masahiro@socionext.com>
References: <1529897685-15029-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1529897685-15029-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UniPhier platform highly relies on the reset controller.
Select RESET_CONTROLLER to enable it forcibly.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index d5aeac3..f34cd1b 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -261,6 +261,7 @@ config ARCH_UNIPHIER
 	bool "Socionext UniPhier SoC Family"
 	select ARCH_HAS_RESET_CONTROLLER
 	select PINCTRL
+	select RESET_CONTROLLER
 	help
 	  This enables support for Socionext UniPhier SoC family.
 
-- 
2.7.4
