From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 2 Apr 2015 17:07:57 +0200
Subject: [PATCH] ARM: at91: add a Kconfig dependency on multi-platform
In-Reply-To: <4695444.mEPNvRWLFJ@wuerfel>
References: <4695444.mEPNvRWLFJ@wuerfel>
Message-ID: <1427987277-29462-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building a legacy (non-multi) platforms and if the ARCH_AT91 config option
is enabled there is a build error. We need AT91 to depend on multi-platform
core type options.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index e2cd30f6c23d..fd95f34945f4 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -1,5 +1,6 @@
 menuconfig ARCH_AT91
 	bool "Atmel SoCs"
+	depends on ARCH_MULTI_V4T || ARCH_MULTI_V5 || ARCH_MULTI_V7
 	select ARCH_REQUIRE_GPIOLIB
 	select COMMON_CLK_AT91
 	select PINCTRL
-- 
2.1.3
