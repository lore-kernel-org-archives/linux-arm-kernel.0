From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  2 Aug 2016 09:44:33 +0200
Subject: [PATCH] ARM: do away with final ARCH_REQUIRE_GPIOLIB
Message-ID: <1470123873-8073-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new user of the Kconfig selection of ARCH_REQUIRE_GPIOLIB
has appeared. Replace with just selecting GPIOLIB.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: I plan to send this directly in this merge
window to get rid of the old Kconfig symbols, please ACK
it.
---
 arch/arm/mach-clps711x/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-clps711x/Kconfig b/arch/arm/mach-clps711x/Kconfig
index dc7c6edeab39..61284b9389cf 100644
--- a/arch/arm/mach-clps711x/Kconfig
+++ b/arch/arm/mach-clps711x/Kconfig
@@ -1,13 +1,13 @@
 menuconfig ARCH_CLPS711X
 	bool "Cirrus Logic EP721x/EP731x-based"
 	depends on ARCH_MULTI_V4T
-	select ARCH_REQUIRE_GPIOLIB
 	select AUTO_ZRELADDR
 	select CLKSRC_OF
 	select CLPS711X_TIMER
 	select COMMON_CLK
 	select CPU_ARM720T
 	select GENERIC_CLOCKEVENTS
+	select GPIOLIB
 	select MFD_SYSCON
 	select OF_IRQ
 	select USE_OF
-- 
2.7.4
