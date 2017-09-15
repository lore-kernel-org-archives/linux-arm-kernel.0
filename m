From: baruch@tkos.co.il (Baruch Siach)
Date: Fri, 15 Sep 2017 10:50:07 +0300
Subject: [PATCH] arm64: dt marvell: extend AP806 system controller size
Message-ID: <d230651ed28aa4344bab7e13e9964d69673ecace.1505461807.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend the container size to 0x2000 to include the gpio controller at
offset 0x1040.

While at it, add start address notation to the gpio node name to match
its 'offset' property.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 4d360713ed12..30d48ecf46e0 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -254,7 +254,7 @@
 
 			ap_syscon: system-controller at 6f4000 {
 				compatible = "syscon", "simple-mfd";
-				reg = <0x6f4000 0x1000>;
+				reg = <0x6f4000 0x2000>;
 
 				ap_clk: clock {
 					compatible = "marvell,ap806-clock";
@@ -265,7 +265,7 @@
 					compatible = "marvell,ap806-pinctrl";
 				};
 
-				ap_gpio: gpio {
+				ap_gpio: gpio at 1040 {
 					compatible = "marvell,armada-8k-gpio";
 					offset = <0x1040>;
 					ngpios = <20>;
-- 
2.14.1
