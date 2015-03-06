From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri,  6 Mar 2015 16:05:20 +0100
Subject: [PATCH v2 02/10] ARM: berlin: select MFD_SYSCON by default
In-Reply-To: <1425654328-26298-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1425654328-26298-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1425654328-26298-3-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The chip and system controller nodes handle sub-devices, such as the
clock, pinctrl or reset controllers. The drivers handling them need a
regmap provided by syscon. Select it by default when using a Berlin SoC.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/mach-berlin/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
index 3e40a947f3ea..742d53a5f7f9 100644
--- a/arch/arm/mach-berlin/Kconfig
+++ b/arch/arm/mach-berlin/Kconfig
@@ -6,6 +6,7 @@ menuconfig ARCH_BERLIN
 	select DW_APB_ICTL
 	select DW_APB_TIMER_OF
 	select GENERIC_IRQ_CHIP
+	select MFD_SYSCON
 	select PINCTRL
 
 if ARCH_BERLIN
-- 
2.3.1
