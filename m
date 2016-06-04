From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  4 Jun 2016 10:09:54 +0300
Subject: [PATCH 02/22] clk: clps711x: Changing the compatibility string to
 match with the smallest supported chip
In-Reply-To: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
References: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
Message-ID: <1465024214-22120-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the compatibility string to match with the smallest
supported chip (EP7209). Since the DT-support for this CPU is not yet
announced, this change is safe.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 Documentation/devicetree/bindings/clock/clps711x-clock.txt | 4 ++--
 drivers/clk/clk-clps711x.c                                 | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/clps711x-clock.txt b/Documentation/devicetree/bindings/clock/clps711x-clock.txt
index ce5a747..f1bd53f 100644
--- a/Documentation/devicetree/bindings/clock/clps711x-clock.txt
+++ b/Documentation/devicetree/bindings/clock/clps711x-clock.txt
@@ -1,7 +1,7 @@
 * Clock bindings for the Cirrus Logic CLPS711X CPUs
 
 Required properties:
-- compatible       : Shall contain "cirrus,clps711x-clk".
+- compatible       : Shall contain "cirrus,ep7209-clk".
 - reg              : Address of the internal register set.
 - startup-frequency: Factory set CPU startup frequency in HZ.
 - #clock-cells     : Should be <1>.
@@ -13,7 +13,7 @@ for the full list of CLPS711X clock IDs.
 Example:
 	clks: clks at 80000000 {
 		#clock-cells = <1>;
-		compatible = "cirrus,ep7312-clk", "cirrus,clps711x-clk";
+		compatible = "cirrus,ep7312-clk", "cirrus,ep7209-clk";
 		reg = <0x80000000 0xc000>;
 		startup-frequency = <73728000>;
 	};
diff --git a/drivers/clk/clk-clps711x.c b/drivers/clk/clk-clps711x.c
index 1f60b02..adaf109 100644
--- a/drivers/clk/clk-clps711x.c
+++ b/drivers/clk/clk-clps711x.c
@@ -184,5 +184,5 @@ static void __init clps711x_clk_init_dt(struct device_node *np)
 	of_clk_add_provider(np, of_clk_src_onecell_get,
 			    &clps711x_clk->clk_data);
 }
-CLK_OF_DECLARE(clps711x, "cirrus,clps711x-clk", clps711x_clk_init_dt);
+CLK_OF_DECLARE(clps711x, "cirrus,ep7209-clk", clps711x_clk_init_dt);
 #endif
-- 
2.4.9
