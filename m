From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Fri, 18 Apr 2014 16:48:13 +0200
Subject: [PATCH v2 13/14] ARM: shmobile: lager-reference: Enable CMT0 in
 device tree
In-Reply-To: <1397832494-20607-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1397832494-20607-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1397832494-20607-14-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the CMT0 device and configure channel 0 as a clock event
provider.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts            | 4 ++++
 arch/arm/mach-shmobile/board-lager-reference.c | 1 -
 arch/arm/mach-shmobile/setup-r8a7790.c         | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 86d676f..68dc594 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -201,6 +201,10 @@
 	};
 };
 
+&cmt0 {
+	status = "ok";
+};
+
 &ether {
 	pinctrl-0 = <&ether_pins &phy1_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 1bca2748..8873c69 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -90,7 +90,6 @@ static void __init lager_add_du_device(void)
  * devices until they get moved to DT.
  */
 static const struct clk_name clk_names[] __initconst = {
-	{ "cmt0", "fck", "sh-cmt-48-gen2.0" },
 	{ "scifa0", NULL, "sh-sci.0" },
 	{ "scifa1", NULL, "sh-sci.1" },
 	{ "scifb0", NULL, "sh-sci.2" },
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 2a67083..ac00e4b 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -291,12 +291,12 @@ void __init r8a7790_add_dt_devices(void)
 	r8a7790_register_scif(7);
 	r8a7790_register_scif(8);
 	r8a7790_register_scif(9);
-	r8a7790_register_cmt(0);
 }
 
 void __init r8a7790_add_standard_devices(void)
 {
 	r8a7790_add_dt_devices();
+	r8a7790_register_cmt(0);
 	r8a7790_register_irqc(0);
 	r8a7790_register_thermal();
 	r8a7790_register_i2c(0);
-- 
1.8.3.2
