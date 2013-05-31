From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 31 May 2013 10:37:54 +0300
Subject: [PATCH 3/3] ARM: OMAP: add vdds_sdi supply for omapdss_sdi.0
In-Reply-To: <1369985874-8571-1-git-send-email-tomi.valkeinen@ti.com>
References: <1369985874-8571-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1369985874-8571-4-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SDI driver gets currently the vdds_sdi regulator via omapdss device.
This is not correct, and we'll change the SDI driver to get the
regulator directly via omapdss_sdi.0 device.

This patch changes the rx51 board file to add vdds_dsi supply for
omapdss_sdi.0 device.

Note that the vdds_sdi supply for omapdss device is still left there, as
the current display driver uses it. When both the board files and the
display driver has been changed, we can remove the unused supply.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 18ca61e..9c2dd10 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -553,6 +553,7 @@ static struct regulator_consumer_supply rx51_vio_supplies[] = {
 
 static struct regulator_consumer_supply rx51_vaux1_consumers[] = {
 	REGULATOR_SUPPLY("vdds_sdi", "omapdss"),
+	REGULATOR_SUPPLY("vdds_sdi", "omapdss_sdi.0"),
 	/* Si4713 supply */
 	REGULATOR_SUPPLY("vdd", "2-0063"),
 	/* lis3lv02d */
-- 
1.8.1.2
