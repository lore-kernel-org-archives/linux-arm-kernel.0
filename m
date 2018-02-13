From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Tue, 13 Feb 2018 13:53:29 +0100
Subject: [PATCH v3 03/11] ARM: dts: STi: Add fake reg property for
 sti-display-subsystem
In-Reply-To: <1518526417-11919-1-git-send-email-patrice.chotard@st.com>
References: <1518526417-11919-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1518526417-11919-4-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

As sti-display-subsystem sub-nodes (sti-compositor, sti-tvout
sti-hdmi, sti-hda and sti-hqvdp) are SoC's IP, we add a fake
reg property.
This allows to fix the following warning when compiling
dtb with W=1 option:

arch/arm/boot/dts/stih410-b2120.dtb: Warning (unit_address_vs_reg):
Node /soc/sti-display-subsystem/sti-hda at 8d02000 has a unit name, but no reg property

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v3: _ none
v2: _ add a fake reg property to node without reg property

 arch/arm/boot/dts/stih407.dtsi      | 4 ++--
 arch/arm/boot/dts/stih410-b2120.dts | 2 +-
 arch/arm/boot/dts/stih410.dtsi      | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
index 11fdecd9312e..4f01777082f5 100644
--- a/arch/arm/boot/dts/stih407.dtsi
+++ b/arch/arm/boot/dts/stih407.dtsi
@@ -11,11 +11,11 @@
 #include <dt-bindings/gpio/gpio.h>
 / {
 	soc {
-		sti-display-subsystem {
+		sti-display-subsystem at 0 {
 			compatible = "st,sti-display-subsystem";
 			#address-cells = <1>;
 			#size-cells = <1>;
-
+			reg = <0 0>;
 			assigned-clocks	= <&clk_s_d2_quadfs 0>,
 					  <&clk_s_d2_quadfs 1>,
 					  <&clk_s_c0_pll1 0>,
diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/stih410-b2120.dts
index 37a42afa0dd1..23199b1b0991 100644
--- a/arch/arm/boot/dts/stih410-b2120.dts
+++ b/arch/arm/boot/dts/stih410-b2120.dts
@@ -61,7 +61,7 @@
 			status = "okay";
 		};
 
-		sti-display-subsystem {
+		sti-display-subsystem at 0 {
 			sti-hda at 8d02000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
index e4b7e3ddc9ee..d9f964702933 100644
--- a/arch/arm/boot/dts/stih410.dtsi
+++ b/arch/arm/boot/dts/stih410.dtsi
@@ -102,11 +102,12 @@
 			status = "disabled";
 		};
 
-		sti-display-subsystem {
+		sti-display-subsystem at 0 {
 			compatible = "st,sti-display-subsystem";
 			#address-cells = <1>;
 			#size-cells = <1>;
 
+			reg = <0 0>;
 			assigned-clocks	= <&clk_s_d2_quadfs 0>,
 					  <&clk_s_d2_quadfs 1>,
 					  <&clk_s_c0_pll1 0>,
-- 
1.9.1
