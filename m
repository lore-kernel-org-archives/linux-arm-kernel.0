From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue,  7 Feb 2012 15:01:15 +0200
Subject: [PATCH v2 4/7] OMAP: 4430sdp: Correct fixed regulator device ID
In-Reply-To: <1328619678-26080-1-git-send-email-peter.ujfalusi@ti.com>
References: <1328619678-26080-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1328619678-26080-5-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The board has two fixed voltage regulator. Correct the
device ID for the vbat, which used -1.
Create defines for the fixed regulator IDs so when adding new
regulators we know the next available ID to use for them.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index f4ac553..d02172d 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -62,6 +62,9 @@
 #define GPIO_WIFI_PMENA		54
 #define GPIO_WIFI_IRQ		53
 
+#define FIXED_REG_VBAT_ID	0
+#define FIXED_REG_VWLAN_ID	1
+
 static const int sdp4430_keymap[] = {
 	KEY(0, 0, KEY_E),
 	KEY(0, 1, KEY_R),
@@ -368,7 +371,7 @@ static struct fixed_voltage_config sdp4430_vbat_pdata = {
 
 static struct platform_device sdp4430_vbat = {
 	.name		= "reg-fixed-voltage",
-	.id		= -1,
+	.id		= FIXED_REG_VBAT_ID,
 	.dev = {
 		.platform_data = &sdp4430_vbat_pdata,
 	},
@@ -478,7 +481,7 @@ static struct fixed_voltage_config sdp4430_vwlan = {
 
 static struct platform_device omap_vwlan_device = {
 	.name		= "reg-fixed-voltage",
-	.id		= 1,
+	.id		= FIXED_REG_VWLAN_ID,
 	.dev = {
 		.platform_data = &sdp4430_vwlan,
 	},
-- 
1.7.8.4
