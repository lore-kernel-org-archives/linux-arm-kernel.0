From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 29 Oct 2015 23:52:41 +0100
Subject: [PATCH 5/7] clocksource/drivers/pxa_timer: Move the Kconfig rule
In-Reply-To: <1446159166-20384-1-git-send-email-daniel.lezcano@linaro.org>
References: <1446159166-20384-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1446159166-20384-5-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of having the clocksource's Kconfig depending on the arch, let the
arch to select the timer it needs.

The CLKSRC_OF dependency is removed because already selected by the ARCH_PXA,
and it is added for SA1100.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/Kconfig            | 3 +++
 drivers/clocksource/Kconfig | 3 +--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 72ad724..aa32286 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -609,6 +609,7 @@ config ARCH_PXA
 	select AUTO_ZRELADDR
 	select COMMON_CLK
 	select CLKDEV_LOOKUP
+	select CLKSRC_PXA
 	select CLKSRC_MMIO
 	select CLKSRC_OF
 	select GENERIC_CLOCKEVENTS
@@ -669,6 +670,8 @@ config ARCH_SA1100
 	select ARCH_SPARSEMEM_ENABLE
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
+	select CLKSRC_PXA
+	select CLKSRC_OF if OF
 	select CPU_FREQ
 	select CPU_SA1100
 	select GENERIC_CLOCKEVENTS
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5cd000c..425abbd 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -289,8 +289,7 @@ config CLKSRC_TANGO_XTAL
 	select CLKSRC_OF
 
 config CLKSRC_PXA
-	def_bool y if ARCH_PXA || ARCH_SA1100
-	select CLKSRC_OF if OF
+	bool
 	help
 	  This enables OST0 support available on PXA and SA-11x0
 	  platforms.
-- 
1.9.1
