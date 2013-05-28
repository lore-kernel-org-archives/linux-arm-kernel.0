From: larsi@wh2.tu-dresden.de (Lars Poeschel)
Date: Tue, 28 May 2013 10:24:57 +0200
Subject: [PATCH] dts: am33xx: Correct properties on gpmc node
Message-ID: <1369729497-11897-1-git-send-email-larsi@wh2.tu-dresden.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lars Poeschel <poeschel@lemonage.de>

The gpmc driver is actually looking for "gpmc,num-cs" and
"gpmc,num-waitpins" properties in DT. The binding doc also states
this.
Correct the properties in the dts to provide the right values for the
gpmc driver.

Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 arch/arm/boot/dts/am33xx.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 1460d9b..8e1248f 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -409,8 +409,8 @@
 			ti,hwmods = "gpmc";
 			reg = <0x50000000 0x2000>;
 			interrupts = <100>;
-			num-cs = <7>;
-			num-waitpins = <2>;
+			gpmc,num-cs = <7>;
+			gpmc,num-waitpins = <2>;
 			#address-cells = <2>;
 			#size-cells = <1>;
 			status = "disabled";
-- 
1.7.10.4
