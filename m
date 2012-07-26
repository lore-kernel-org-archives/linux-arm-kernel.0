From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Thu, 26 Jul 2012 07:48:44 +0200
Subject: [PATCH v2] ARM: i.MX6: set ARCH_NR_GPIO to 224
Message-ID: <1343281724-23085-1-git-send-email-dirk.behme@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthias Thomae <matthias.thomae@de.bosch.com>

Set ARCH_NR_GPIO for the i.MX6 processor family, which has 7 GPIO
controllers with 32 signals each. The default of 256 GPIOs wastes
some static table space as explained in Documentation/gpio.txt.

Signed-off-by: Matthias Thomae <matthias.thomae@de.bosch.com>
CC: Shawn Guo <shawn.guo@linaro.org>
---

Changes in v2: Fix typo in the subject: 244 -> 224

 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b25c9d3..5e4cde3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1626,6 +1626,7 @@ config ARCH_NR_GPIO
 	default 355 if ARCH_U8500
 	default 264 if MACH_H4700
 	default 512 if SOC_OMAP5
+	default 224 if SOC_IMX6Q
 	default 0
 	help
 	  Maximum number of GPIOs in the system.
-- 
1.7.0.4
