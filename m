From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 21 Jul 2018 19:37:19 +0200
Subject: [PATCH 1/3] ARM: meson: select HAVE_ARM_TWD when SMP support is
 enabled
In-Reply-To: <20180721173721.31361-1-martin.blumenstingl@googlemail.com>
References: <20180721173721.31361-1-martin.blumenstingl@googlemail.com>
Message-ID: <20180721173721.31361-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32-bit Meson SoCs come with a per-core Cortex-A9 (Meson8 and
Meson8m2) or Cortex-A5 (Meson8b) "Timer-Watchdog (aka TWD), which
provides both a per-cpu local timer and watchdog".
Selecting HAVE_ARM_TWD allows adding a "arm,cortex-a5-twd-timer" or
"arm,cortex-a9-twd-timer" compatible timer to the SoC's .dts.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/mach-meson/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index d51cfda953d4..27ae58f87406 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -10,6 +10,7 @@ menuconfig ARCH_MESON
 	select COMMON_CLK
 	select COMMON_CLK_AMLOGIC
 	select HAVE_ARM_SCU if SMP
+	select HAVE_ARM_TWD if SMP
 
 if ARCH_MESON
 
-- 
2.18.0
