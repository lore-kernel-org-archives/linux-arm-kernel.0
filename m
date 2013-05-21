From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 21 May 2013 14:14:28 +0200
Subject: [PATCH v4 07/21] ARM: shmobile: r8a7779: Add pin control device to
 device tree
In-Reply-To: <1369138482-5871-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1369138482-5871-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1369138482-5871-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a pfc node to the r8a7779 device tree and remove manual pinmux
initialization from the corresponding board files.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7779.dtsi                  |  5 +++++
 arch/arm/mach-shmobile/board-marzen-reference.c | 17 ++++++++---------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 7f146c6..9dfc438 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -101,6 +101,11 @@
 		interrupts = <0 81 0x4>;
 	};
 
+	pfc: pfc at fffc0000 {
+		compatible = "renesas,pfc-r8a7779";
+		reg = <0xfffc0000 0x23c>;
+	};
+
 	thermal at ffc48000 {
 		compatible = "renesas,rcar-thermal";
 		reg = <0xffc48000 0x38>;
diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index 5332e89..fa7fc07 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -28,24 +28,24 @@
 
 static const struct pinctrl_map marzen_pinctrl_map[] = {
 	/* SCIF2 (CN18: DEBUG0) */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.2", "pfc-r8a7779",
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.2", "fffc0000.pfc",
 				  "scif2_data_c", "scif2"),
 	/* SCIF4 (CN19: DEBUG1) */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "pfc-r8a7779",
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "fffc0000.pfc",
 				  "scif4_data", "scif4"),
 	/* SDHI0 */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7779",
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "fffc0000.pfc",
 				  "sdhi0_data4", "sdhi0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7779",
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "fffc0000.pfc",
 				  "sdhi0_ctrl", "sdhi0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7779",
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "fffc0000.pfc",
 				  "sdhi0_cd", "sdhi0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7779",
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "fffc0000.pfc",
 				  "sdhi0_wp", "sdhi0"),
 	/* SMSC */
-	PIN_MAP_MUX_GROUP_DEFAULT("18000000.lan0", "pfc-r8a7779",
+	PIN_MAP_MUX_GROUP_DEFAULT("18000000.lan0", "fffc0000.pfc",
 				  "intc_irq1_b", "intc"),
-	PIN_MAP_MUX_GROUP_DEFAULT("18000000.lan0", "pfc-r8a7779",
+	PIN_MAP_MUX_GROUP_DEFAULT("18000000.lan0", "fffc0000.pfc",
 				  "lbsc_ex_cs0", "lbsc"),
 };
 
@@ -53,7 +53,6 @@ static void __init marzen_init(void)
 {
 	pinctrl_register_mappings(marzen_pinctrl_map,
 				  ARRAY_SIZE(marzen_pinctrl_map));
-	r8a7779_pinmux_init();
 
 	r8a7779_add_standard_devices_dt();
 }
-- 
1.8.1.5
