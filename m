From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:30:55 +0900
Subject: [PATCH 21/69] ARM: shmobile: r8a7779: tidyup DT node naming
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <2624705ceb7b139cffdb409682d3e1bc480abec7.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

According to ePAPR spec,
this patch tidies up DT node name and related clock.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi         | 8 ++++----
 arch/arm/mach-shmobile/clock-r8a7779.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index be737ef..05fd41c 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -207,7 +207,7 @@
 		interrupts = <0 100 0x4>;
 	};
 
-	sdhi0: sdhi at ffe4c000 {
+	sdhi0: sd at ffe4c000 {
 		compatible = "renesas,sdhi-r8a7779";
 		reg = <0xffe4c000 0x100>;
 		interrupt-parent = <&gic>;
@@ -217,7 +217,7 @@
 		status = "disabled";
 	};
 
-	sdhi1: sdhi at ffe4d000 {
+	sdhi1: sd at ffe4d000 {
 		compatible = "renesas,sdhi-r8a7779";
 		reg = <0xffe4d000 0x100>;
 		interrupt-parent = <&gic>;
@@ -227,7 +227,7 @@
 		status = "disabled";
 	};
 
-	sdhi2: sdhi at ffe4e000 {
+	sdhi2: sd at ffe4e000 {
 		compatible = "renesas,sdhi-r8a7779";
 		reg = <0xffe4e000 0x100>;
 		interrupt-parent = <&gic>;
@@ -237,7 +237,7 @@
 		status = "disabled";
 	};
 
-	sdhi3: sdhi at ffe4f000 {
+	sdhi3: sd at ffe4f000 {
 		compatible = "renesas,sdhi-r8a7779";
 		reg = <0xffe4f000 0x100>;
 		interrupt-parent = <&gic>;
diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index b545c8d..f1fb89b 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -204,13 +204,13 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-hspi.2", &mstp_clks[MSTP007]), /* HSPI2 */
 	CLKDEV_DEV_ID("fffc6000.spi", &mstp_clks[MSTP007]), /* HSPI2 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP323]), /* SDHI0 */
-	CLKDEV_DEV_ID("ffe4c000.sdhi", &mstp_clks[MSTP323]), /* SDHI0 */
+	CLKDEV_DEV_ID("ffe4c000.sd", &mstp_clks[MSTP323]), /* SDHI0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP322]), /* SDHI1 */
-	CLKDEV_DEV_ID("ffe4d000.sdhi", &mstp_clks[MSTP322]), /* SDHI1 */
+	CLKDEV_DEV_ID("ffe4d000.sd", &mstp_clks[MSTP322]), /* SDHI1 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP321]), /* SDHI2 */
-	CLKDEV_DEV_ID("ffe4e000.sdhi", &mstp_clks[MSTP321]), /* SDHI2 */
+	CLKDEV_DEV_ID("ffe4e000.sd", &mstp_clks[MSTP321]), /* SDHI2 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.3", &mstp_clks[MSTP320]), /* SDHI3 */
-	CLKDEV_DEV_ID("ffe4f000.sdhi", &mstp_clks[MSTP320]), /* SDHI3 */
+	CLKDEV_DEV_ID("ffe4f000.sd", &mstp_clks[MSTP320]), /* SDHI3 */
 	CLKDEV_DEV_ID("rcar-du-r8a7779", &mstp_clks[MSTP103]), /* DU */
 };
 
-- 
1.8.4
