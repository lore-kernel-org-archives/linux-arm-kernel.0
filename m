From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 23 Nov 2018 20:53:06 +0100
Subject: [PATCH 1/6] ARM: meson: select HAVE_ARM_TWD and ARM_GLOBAL_TIMER
In-Reply-To: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
References: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
Message-ID: <20181123195311.4578-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32-bit Meson SoCs use multiple Cortex-A9 (Meson8 and Meson8m2) or
Cortex-A5 (Meson8b) CPU cores. These come with the "ARM global timer"
and "Timer-Watchdog" (aka TWD, which provides both a per-cpu local timer
and watchdog).

Selecting ARM_GLOBAL_TIMER and HAVE_ARM_TWD allows us to add the timers
to the SoC.dtsi files.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/mach-meson/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index d51cfda953d4..b16831697183 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -4,12 +4,14 @@ menuconfig ARCH_MESON
 	select GPIOLIB
 	select GENERIC_IRQ_CHIP
 	select ARM_GIC
+	select ARM_GLOBAL_TIMER
 	select CACHE_L2X0
 	select PINCTRL
 	select PINCTRL_MESON
 	select COMMON_CLK
 	select COMMON_CLK_AMLOGIC
 	select HAVE_ARM_SCU if SMP
+	select HAVE_ARM_TWD if SMP
 
 if ARCH_MESON
 
-- 
2.19.2
