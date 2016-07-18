From: michael.weiser@gmx.de (Michael Weiser)
Date: Mon, 18 Jul 2016 18:23:55 +0200
Subject: [PATCH 3/3] ARM: sunxi: enable big-endian
In-Reply-To: <20160718162355.20273-1-michael.weiser@gmx.de>
References: <20160718162355.20273-1-michael.weiser@gmx.de>
Message-ID: <20160718162355.20273-4-michael.weiser@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At least the Cubieboard2 incarnation of sunxi works correctly in
big-endian mode. Allow the selection of big-endian.

Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
---
 arch/arm/mach-sunxi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index c124d65..4dcbbfe 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1,6 +1,7 @@
 menuconfig ARCH_SUNXI
 	bool "Allwinner SoCs"
 	depends on ARCH_MULTI_V7
+	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_HAS_RESET_CONTROLLER
 	select CLKSRC_MMIO
-- 
2.9.0
