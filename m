From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 17:52:42 +0100
Subject: [PATCH 6/7] clk: mvebu: rename armada-xp-cpu-clockctrl to
 armada-xp-cpu-clock
In-Reply-To: <1353343963-23034-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353343963-23034-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353343963-23034-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the existing clock drivers have a compatible string that ends
with "-clock", so change the "armada-xp-cpu-clockctrl" compatible
strings of the mvebu clk-cpu.c driver to "armada-xp-cpu-clock".

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/clock/mvebu-cpu-clock.txt  |    4 ++--
 arch/arm/boot/dts/armada-xp.dtsi                   |    2 +-
 drivers/clk/mvebu/clk-cpu.c                        |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
index 1fb5a64..feb8301 100644
--- a/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
+++ b/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
@@ -2,14 +2,14 @@ Device Tree Clock bindings for cpu clock of Marvell EBU platforms
 
 Required properties:
 - compatible : shall be one of the following:
-	"marvell,armada-xp-cpu-clockctrl" - cpu clocks for Armada XP
+	"marvell,armada-xp-cpu-clock" - cpu clocks for Armada XP
 - reg : Address and length of the clock complex register set
 - #clock-cells : should be set to 1.
 - clocks : shall be the input parent clock phandle for the clock.
 
 cpuclk: clock-complex at d0018700 {
 	#clock-cells = <1>;
-	compatible = "marvell,armada-xp-cpu-clockctrl";
+	compatible = "marvell,armada-xp-cpu-clock";
 	reg = <0xd0018700 0xA0>;
 	clocks = <&coreclk 1>;
 }
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index d05515c..781127e 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -62,7 +62,7 @@
 
 		cpuclk: clock-complex at d0018700 {
 			#clock-cells = <1>;
-			compatible = "marvell,armada-xp-cpu-clockctrl";
+			compatible = "marvell,armada-xp-cpu-clock";
 			reg = <0xd0018700 0xA0>;
 			clocks = <&coreclk 1>;
 		};
diff --git a/drivers/clk/mvebu/clk-cpu.c b/drivers/clk/mvebu/clk-cpu.c
index 3d7c9f1..44f541a 100644
--- a/drivers/clk/mvebu/clk-cpu.c
+++ b/drivers/clk/mvebu/clk-cpu.c
@@ -156,7 +156,7 @@ bail_out:
 
 static const __initconst struct of_device_id clk_cpu_match[] = {
 	{
-		.compatible = "marvell,armada-xp-cpu-clockctrl",
+		.compatible = "marvell,armada-xp-cpu-clock",
 		.data = of_cpu_clk_setup,
 	},
 	{
-- 
1.7.9.5
