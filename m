From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 13 May 2013 10:53:08 +0200
Subject: [PATCH] ARM: sunxi: select ARCH_REQUIRE_GPIOLIB
Message-ID: <1368435188-26965-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_SUNXI currently doesn't enable a gpiolib, which causes build
problems when building a kernel with only the sunxi platform enabled.
Select ARCH_REQUIRE_GPIOLIB to solve this.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index d259c78..5b045e3 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1,5 +1,6 @@
 config ARCH_SUNXI
 	bool "Allwinner A1X SOCs" if ARCH_MULTI_V7
+	select ARCH_REQUIRE_GPIOLIB
 	select CLKSRC_MMIO
 	select CLKSRC_OF
 	select COMMON_CLK
-- 
1.8.1.2
