From: b.galvani@gmail.com (Beniamino Galvani)
Date: Thu,  1 May 2014 21:50:35 +0200
Subject: [PATCH 2/2] ARM: dts: rockchip: add root compatible properties
In-Reply-To: <1398973835-26303-1-git-send-email-b.galvani@gmail.com>
References: <1398973835-26303-1-git-send-email-b.galvani@gmail.com>
Message-ID: <1398973835-26303-2-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the missing 'compatible' property to device tree root node of

 - rk3066a-bqcurie2.dts
 - rk3188-radxarock.dts

and document the new values.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.txt |   10 ++++++++++
 arch/arm/boot/dts/rk3066a-bqcurie2.dts             |    1 +
 arch/arm/boot/dts/rk3188-radxarock.dts             |    1 +
 3 files changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip.txt

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
new file mode 100644
index 0000000..12b84e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -0,0 +1,10 @@
+Rockchip platforms device tree bindings
+---------------------------------------
+
+- bq Curie 2 tablet:
+    Required root node properties:
+      - compatible = "bq,curie2", "rockchip,rk3066a";
+
+- Radxa Rock board:
+    Required root node properties:
+      - compatible = "radxa,rock", "rockchip,rk3188";
diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
index 035df40..7616bd9 100644
--- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
+++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
@@ -18,6 +18,7 @@
 
 / {
 	model = "bq Curie 2";
+	compatible = "bq,curie2", "rockchip,rk3066a";
 
 	memory {
 		reg = <0x60000000 0x40000000>;
diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index 3ba1968..a5eee55 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -17,6 +17,7 @@
 
 / {
 	model = "Radxa Rock";
+	compatible = "radxa,rock", "rockchip,rk3188";
 
 	memory {
 		reg = <0x60000000 0x80000000>;
-- 
1.7.10.4
