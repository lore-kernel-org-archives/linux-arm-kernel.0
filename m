From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  7 Jul 2014 09:14:41 +0200
Subject: [PATCH] ARM: footbridge: select machine dir based on ARCH_FOOTBRIDGE
Message-ID: <1404717281-11969-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Syntactically FOOTBRIDGE and ARCH_FOOTBRIDGE are identical (the former
is defined in an if ARCH_FOOTBRIDGE block and the latter selects the
former).

Sematically FOOTBRIDGE means "we have a DC21285 (aka footbridge) device
in the system" and ARCH_FOOTBRIDGE is the support for boards with a
footbridge device, so ARCH_FOOTBRIDGE is the better symbol here.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 6721fab13734..cb30f552e86f 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -154,6 +154,7 @@ machine-$(CONFIG_ARCH_EBSA110)		+= ebsa110
 machine-$(CONFIG_ARCH_EFM32)		+= efm32
 machine-$(CONFIG_ARCH_EP93XX)		+= ep93xx
 machine-$(CONFIG_ARCH_EXYNOS)		+= exynos
+machine-$(CONFIG_ARCH_FOOTBRIDGE)	+= footbridge
 machine-$(CONFIG_ARCH_GEMINI)		+= gemini
 machine-$(CONFIG_ARCH_HIGHBANK)		+= highbank
 machine-$(CONFIG_ARCH_HI3xxx)		+= hisi
@@ -204,7 +205,6 @@ machine-$(CONFIG_ARCH_VEXPRESS)		+= vexpress
 machine-$(CONFIG_ARCH_VT8500)		+= vt8500
 machine-$(CONFIG_ARCH_W90X900)		+= w90x900
 machine-$(CONFIG_ARCH_ZYNQ)		+= zynq
-machine-$(CONFIG_FOOTBRIDGE)		+= footbridge
 machine-$(CONFIG_PLAT_SPEAR)		+= spear
 
 # Platform directory name.  This list is sorted alphanumerically
-- 
2.0.0
