From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat,  5 Oct 2013 16:39:18 +0200
Subject: [PATCH 2/4] ARM: sunxi: Select ARCH_HAS_RESET_CONTROLLER
In-Reply-To: <1380983960-11087-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1380983960-11087-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1380983960-11087-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 has a reset controller, and we have to select this option to
have access to the reset controller framework.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 33cef54..98a1859 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1,5 +1,6 @@
 config ARCH_SUNXI
 	bool "Allwinner A1X SOCs" if ARCH_MULTI_V7
+	select ARCH_HAS_RESET_CONTROLLER
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKSRC_MMIO
 	select CLKSRC_OF
-- 
1.8.4
