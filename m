From: lost.distance@yahoo.com (Paul Parsons)
Date: Mon, 27 Feb 2012 01:58:45 +0000 (GMT)
Subject: [PATCH v3 REPOST] pxa/hx4700: Fix PXA_GPIO_IRQ_BASE/IRQ_NUM values
Message-ID: <1330307925.11845.YahooMailClassic@web29010.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hx4700 platform has 72 board gpios: 64 ASIC3 gpios numbered 192..255, and
8 EGPIO gpios numbered 256..263 (plus a 9th which is not used).
Thus the new CONFIG_ARCH_NR_GPIO config option must be set to 264.

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
---

V3:
Description change: 64 ASIC3 gpios + 8 EGPIO gpios = 72 board gpios, not 70.

diff -ru clean-3.3-rc1/arch/arm/Kconfig linux-3.3-rc1/arch/arm/Kconfig
--- clean-3.3-rc1/arch/arm/Kconfig	2012-01-19 23:04:48.000000000 +0000
+++ linux-3.3-rc1/arch/arm/Kconfig	2012-01-30 17:11:35.897518763 +0000
@@ -1580,6 +1580,7 @@
 	int
 	default 1024 if ARCH_SHMOBILE || ARCH_TEGRA
 	default 350 if ARCH_U8500
+	default 264 if MACH_H4700
 	default 0
 	help
 	  Maximum number of GPIOs in the system.
