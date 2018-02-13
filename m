From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Tue, 13 Feb 2018 13:53:33 +0100
Subject: [PATCH v3 07/11] ARM: dts: STi: Add fake reg for restart,
 powerdown and picophy/softreset
In-Reply-To: <1518526417-11919-1-git-send-email-patrice.chotard@st.com>
References: <1518526417-11919-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1518526417-11919-8-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Add fake reg property for restart, powerdown, picophyreset
and softreset.
This allows to fix the following warning when compiling
dtb with W=1 option:

arch/arm/boot/dts/stih407-b2120.dtb: Warning (simple_bus_reg):
Node /soc/restart missing or empty reg/ranges property
arch/arm/boot/dts/stih407-b2120.dtb: Warning (simple_bus_reg):
Node /soc/powerdown-controller missing or empty reg/ranges property
arch/arm/boot/dts/stih407-b2120.dtb: Warning (simple_bus_reg):
Node /soc/softreset-controller missing or empty reg/ranges property
arch/arm/boot/dts/stih407-b2120.dtb: Warning (simple_bus_reg):
Node /soc/picophyreset-controller missing or empty reg/ranges property

arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /soc/restart missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /soc/powerdown-controller missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /soc/softreset-controller missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /soc/picophyreset-controller missing or empty reg/ranges property

arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
Node /soc/restart missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
Node /soc/powerdown-controller missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
Node /soc/softreset-controller missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
Node /soc/picophyreset-controller missing or empty reg/ranges property

arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /soc/restart missing or empty reg/ranges property
arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /soc/powerdown-controller missing or empty reg/ranges property
arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /soc/softreset-controller missing or empty reg/ranges property
arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /soc/picophyreset-controller missing or empty reg/ranges property

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v3: _ none
v2: _ add a fake reg property to node without reg property


 arch/arm/boot/dts/stih407-family.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 5a0bad07da9e..00a3838236d1 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -125,24 +125,28 @@
 		ranges;
 		compatible = "simple-bus";
 
-		restart {
+		restart: restart-controller at 0 {
 			compatible = "st,stih407-restart";
+			reg = <0 0>;
 			st,syscfg = <&syscfg_sbc_reg>;
 			status = "okay";
 		};
 
-		powerdown: powerdown-controller {
+		powerdown: powerdown-controller at 0 {
 			compatible = "st,stih407-powerdown";
+			reg = <0 0>;
 			#reset-cells = <1>;
 		};
 
-		softreset: softreset-controller {
+		softreset: softreset-controller at 0 {
 			compatible = "st,stih407-softreset";
+			reg = <0 0>;
 			#reset-cells = <1>;
 		};
 
-		picophyreset: picophyreset-controller {
+		picophyreset: picophyreset-controller at 0 {
 			compatible = "st,stih407-picophyreset";
+			reg = <0 0>;
 			#reset-cells = <1>;
 		};
 
-- 
1.9.1
