From: mcuos.com@gmail.com (Wan ZongShun)
Date: Fri, 16 Jul 2010 17:05:11 +0800
Subject: [PATCH] ARM/nuc900: add nuc900 keypad arch platform data
Message-ID: <4C4020C7.2060001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to add nuc900 keypad arch platform data.

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>

---
 arch/arm/mach-w90x900/dev.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-w90x900/dev.c b/arch/arm/mach-w90x900/dev.c
index 73b3eca..7ae5438 100644
--- a/arch/arm/mach-w90x900/dev.c
+++ b/arch/arm/mach-w90x900/dev.c
@@ -37,6 +37,7 @@
 #include <mach/map.h>
 #include <mach/fb.h>
 #include <mach/regs-ldm.h>
+#include <mach/w90p910_keypad.h>

 #include "cpu.h"

@@ -362,6 +363,39 @@ struct platform_device nuc900_device_fmi = {

 /* KPI controller*/

+static int nuc900_keymap[] = {
+	KEY(0, 0, KEY_A),
+	KEY(0, 1, KEY_B),
+	KEY(0, 2, KEY_C),
+	KEY(0, 3, KEY_D),
+
+	KEY(1, 0, KEY_E),
+	KEY(1, 1, KEY_F),
+	KEY(1, 2, KEY_G),
+	KEY(1, 3, KEY_H),
+
+	KEY(2, 0, KEY_I),
+	KEY(2, 1, KEY_J),
+	KEY(2, 2, KEY_K),
+	KEY(2, 3, KEY_L),
+
+	KEY(3, 0, KEY_M),
+	KEY(3, 1, KEY_N),
+	KEY(3, 2, KEY_O),
+	KEY(3, 3, KEY_P),
+};
+
+static struct matrix_keymap_data nuc900_map_data = {
+	.keymap			= nuc900_keymap,
+	.keymap_size		= ARRAY_SIZE(nuc900_keymap),
+};
+
+struct w90p910_keypad_platform_data nuc900_keypad_info = {
+	.keymap_data	= &nuc900_map_data,
+	.prescale	= 0xfa,
+	.debounce	= 0x50,
+};
+
 static struct resource nuc900_kpi_resource[] = {
 	[0] = {
 		.start = W90X900_PA_KPI,
@@ -381,6 +415,9 @@ struct platform_device nuc900_device_kpi = {
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(nuc900_kpi_resource),
 	.resource	= nuc900_kpi_resource,
+	.dev		= {
+				.platform_data = &nuc900_keypad_info,
+			}
 };

 /* LCD controller*/
-- 
1.6.3.3
