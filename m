From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  3 Feb 2013 12:24:48 +0100
Subject: [PATCH] ARM: multiplatform: Sort the max gpio numbers.
Message-ID: <1359890688-10336-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building a multiplatform kernel, we could end up with a smaller
number of GPIOs than the one required by the platform the kernel was
running on.

Sort the max GPIO number by descending order so that we always take the
highest number required.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/Kconfig |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1e86fa9..852ae76 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1626,13 +1626,16 @@ config LOCAL_TIMERS
 	  accounting to be spread across the timer interval, preventing a
 	  "thundering herd" at every timer tick.
 
+# The GPIO number here must be sorted by descending number. In case of
+# a multiplatform kernel, we just want the highest value required by the
+# selected platforms.
 config ARCH_NR_GPIO
 	int
 	default 1024 if ARCH_SHMOBILE || ARCH_TEGRA
-	default 355 if ARCH_U8500
-	default 264 if MACH_H4700
 	default 512 if SOC_OMAP5
+	default 355 if ARCH_U8500
 	default 288 if ARCH_VT8500 || ARCH_SUNXI
+	default 264 if MACH_H4700
 	default 0
 	help
 	  Maximum number of GPIOs in the system.
-- 
1.7.10.4
