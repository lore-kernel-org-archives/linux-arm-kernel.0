From: bcm@fixthebug.org (Christian Daudt)
Date: Mon, 23 Sep 2013 10:20:34 -0700
Subject: [PATCH v2 2/4] rename ARCH_BCM to ARCH_BCM_MOBILE (clocksource)
In-Reply-To: <1379956836-5866-1-git-send-email-bcm@fixthebug.org>
References: <1379956836-5866-1-git-send-email-bcm@fixthebug.org>
Message-ID: <1379956836-5866-3-git-send-email-bcm@fixthebug.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently ARCH_BCM has been used for Broadcom
Mobile V7 based SoCs. In order to allow other Broadcom
SoCs to also use mach-bcm directory and files, this patch
renames the original ARCH_BCM to ARCH_BCM_MOBILE, and
uses ARCH_BCM to define any Broadcom chip residing
in mach-bcm directory.

Signed-off-by: Christian Daudt <bcm@fixthebug.org>
Acked-by: Olof Johansson <olof@lixom.net>

Changes from v1:
 - fix alpha ordering in dts/Makefile
 - break into 4 patches for separate subsys

diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 704d6d3..4207ab4 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -25,7 +25,7 @@ obj-$(CONFIG_SUN4I_TIMER)	+= sun4i_timer.o
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra20_timer.o
 obj-$(CONFIG_VT8500_TIMER)	+= vt8500_timer.o
 obj-$(CONFIG_ARCH_NSPIRE)	+= zevio-timer.o
-obj-$(CONFIG_ARCH_BCM)		+= bcm_kona_timer.o
+obj-$(CONFIG_ARCH_BCM_MOBILE)	+= bcm_kona_timer.o
 obj-$(CONFIG_CADENCE_TTC_TIMER)	+= cadence_ttc_timer.o
 obj-$(CONFIG_CLKSRC_EXYNOS_MCT)	+= exynos_mct.o
 obj-$(CONFIG_CLKSRC_SAMSUNG_PWM)	+= samsung_pwm_timer.o
-- 
1.7.10.4
