From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Fri, 18 Apr 2014 16:48:14 +0200
Subject: [PATCH v2 14/14] ARM: shmobile: koelsch-reference: Enable CMT0 in
 device tree
In-Reply-To: <1397832494-20607-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1397832494-20607-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1397832494-20607-15-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the CMT0 device and configure channel 0 as a clock event
provider.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts            | 4 ++++
 arch/arm/mach-shmobile/board-koelsch-reference.c | 1 -
 arch/arm/mach-shmobile/setup-r8a7791.c           | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 0d69813..45334c3 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -290,6 +290,10 @@
 	};
 };
 
+&cmt0 {
+	status = "ok";
+};
+
 &ether {
 	pinctrl-0 = <&ether_pins &phy1_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index bd90932..6b3b354 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -86,7 +86,6 @@ static void __init koelsch_add_du_device(void)
  * devices until they get moved to DT.
  */
 static const struct clk_name clk_names[] __initconst = {
-	{ "cmt0", "fck", "sh-cmt-48-gen2.0" },
 	{ "scifa0", NULL, "sh-sci.0" },
 	{ "scifa1", NULL, "sh-sci.1" },
 	{ "scifb0", NULL, "sh-sci.2" },
diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index 9839dac..e66f777 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -197,12 +197,12 @@ void __init r8a7791_add_dt_devices(void)
 	r8a7791_register_scif(12);
 	r8a7791_register_scif(13);
 	r8a7791_register_scif(14);
-	r8a7791_register_cmt(0);
 }
 
 void __init r8a7791_add_standard_devices(void)
 {
 	r8a7791_add_dt_devices();
+	r8a7791_register_cmt(0);
 	r8a7791_register_irqc(0);
 	r8a7791_register_thermal();
 }
-- 
1.8.3.2
