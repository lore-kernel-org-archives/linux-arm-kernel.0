From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:28 +0900
Subject: [PATCH 02/69] ARM: shmobile: r8a7779: tidyup I2C driver name on DTSI
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <6363070ef7744ad8b6af2ef37afc913c41e82547.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

10e8d4f6dddb0f9dc408c2f2bde8399b243a42ca
(ARM: mach-shmobile: r8a7779: Minimal setup using DT)
added I2C driver, but it was SH-Mobile I2C.
R-Car H1 needs R-Car I2C driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 19faeac..da61d27 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -153,7 +153,7 @@
 	i2c0: i2c at ffc70000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,i2c-r8a7779";
 		reg = <0xffc70000 0x1000>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 79 0x4>;
@@ -163,7 +163,7 @@
 	i2c1: i2c at ffc71000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,i2c-r8a7779";
 		reg = <0xffc71000 0x1000>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 82 0x4>;
@@ -173,7 +173,7 @@
 	i2c2: i2c at ffc72000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,i2c-r8a7779";
 		reg = <0xffc72000 0x1000>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 80 0x4>;
@@ -183,7 +183,7 @@
 	i2c3: i2c at ffc73000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,i2c-r8a7779";
 		reg = <0xffc73000 0x1000>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 81 0x4>;
-- 
1.8.4
