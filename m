From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 25 Mar 2013 23:17:32 +0800
Subject: [PATCH 6/6] ARM: mxs: move timer driver into drivers/clocksource
In-Reply-To: <1364224652-28332-1-git-send-email-shawn.guo@linaro.org>
References: <1364224652-28332-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364224652-28332-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move mxs timer driver into drivers/clocksource as mxs_timer.c.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/Makefile                         |    2 +-
 drivers/clocksource/Makefile                       |    1 +
 .../timer.c => drivers/clocksource/mxs_timer.c     |    0
 3 files changed, 2 insertions(+), 1 deletion(-)
 rename arch/arm/mach-mxs/timer.c => drivers/clocksource/mxs_timer.c (100%)

diff --git a/arch/arm/mach-mxs/Makefile b/arch/arm/mach-mxs/Makefile
index 3d3c8a9..76c336e 100644
--- a/arch/arm/mach-mxs/Makefile
+++ b/arch/arm/mach-mxs/Makefile
@@ -1,5 +1,5 @@
 # Common support
-obj-y := icoll.o ocotp.o system.o timer.o mm.o
+obj-y := icoll.o ocotp.o system.o mm.o
 
 obj-$(CONFIG_PM) += pm.o
 
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 4d8283a..89c5adc 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_CLKSRC_NOMADIK_MTU)	+= nomadik-mtu.o
 obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
 obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= time-armada-370-xp.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835_timer.o
+obj-$(CONFIG_ARCH_MXS)		+= mxs_timer.o
 obj-$(CONFIG_SUNXI_TIMER)	+= sunxi_timer.o
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra20_timer.o
 obj-$(CONFIG_VT8500_TIMER)	+= vt8500_timer.o
diff --git a/arch/arm/mach-mxs/timer.c b/drivers/clocksource/mxs_timer.c
similarity index 100%
rename from arch/arm/mach-mxs/timer.c
rename to drivers/clocksource/mxs_timer.c
-- 
1.7.9.5
