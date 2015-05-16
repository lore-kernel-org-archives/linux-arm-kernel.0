From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 16 May 2015 02:23:30 +0200
Subject: [PATCH 01/14] ARM: berlin: select MFD_SYSCON by default
In-Reply-To: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1431735823-28006-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Antoine Tenart <antoine.tenart@free-electrons.com>

The chip and system controller nodes handle sub-devices, such as the
clock, pinctrl or reset controllers. The drivers handling them need a
regmap provided by syscon. Select it by default when using a Berlin SoC.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
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
2.1.0
