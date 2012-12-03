From: rajanikanth.hv@linaro.org (Rajanikanth H.V)
Date: Mon,  3 Dec 2012 23:42:55 +0530
Subject: [PATCH 2/2] ab8500: promote ab8500_fg probe before ab8500_btemp probe
In-Reply-To: <1354558375-15110-1-git-send-email-rajanikanth.hv@linaro.org>
References: <1354558375-15110-1-git-send-email-rajanikanth.hv@linaro.org>
Message-ID: <1354558375-15110-2-git-send-email-rajanikanth.hv@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>

ab8500_fg driver prepares instance list of fuelgauge which is
required by btemp driver for battery identification. So make sure
that ab8500 fuelgauge list is ready before btemp driver starts.

for '3.7-rc5': of git://git.infradead.org/battery-2.6.git

Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Rajanikanth H.V <rajanikanth.hv@stericsson.com>
---
 drivers/power/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index 696e3a9..070c73d 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -38,7 +38,7 @@ obj-$(CONFIG_CHARGER_PCF50633)	+= pcf50633-charger.o
 obj-$(CONFIG_BATTERY_JZ4740)	+= jz4740-battery.o
 obj-$(CONFIG_BATTERY_INTEL_MID)	+= intel_mid_battery.o
 obj-$(CONFIG_BATTERY_RX51)	+= rx51_battery.o
-obj-$(CONFIG_AB8500_BM)		+= ab8500_bmdata.o ab8500_charger.o ab8500_btemp.o ab8500_fg.o abx500_chargalg.o
+obj-$(CONFIG_AB8500_BM)		+= ab8500_bmdata.o ab8500_charger.o ab8500_fg.o ab8500_btemp.o abx500_chargalg.o
 obj-$(CONFIG_CHARGER_ISP1704)	+= isp1704_charger.o
 obj-$(CONFIG_CHARGER_MAX8903)	+= max8903_charger.o
 obj-$(CONFIG_CHARGER_TWL4030)	+= twl4030_charger.o
-- 
1.7.10.4
