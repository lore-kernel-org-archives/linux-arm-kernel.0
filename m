From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 12 Oct 2014 17:40:24 +0800
Subject: [PATCH 4/5] ARM: sunxi: Select ARCH_HAS_RESET_CONTROLLER and
 RESET_CONTROLLER for sun9i
In-Reply-To: <1413106825-5777-1-git-send-email-wens@csie.org>
References: <1413106825-5777-1-git-send-email-wens@csie.org>
Message-ID: <1413106825-5777-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A80 SoC has reset controls matching bus clock gates.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/mach-sunxi/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index d04f84b..a77604f 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -45,6 +45,8 @@ config MACH_SUN8I
 config MACH_SUN9I
 	bool "Allwinner (sun9i) SoCs support"
 	default ARCH_SUNXI
+	select ARCH_HAS_RESET_CONTROLLER
 	select ARM_GIC
+	select RESET_CONTROLLER
 
 endif
-- 
2.1.1
