From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 19 Aug 2015 12:20:03 +0800
Subject: [PATCH v3 2/8] rsb: sunxi: Add Allwinner Reduced Serial Bus (RSB)
 controller bindings
In-Reply-To: <1439958009-14056-1-git-send-email-wens@csie.org>
References: <1439958009-14056-1-git-send-email-wens@csie.org>
Message-ID: <1439958009-14056-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent Allwinner SoCs, starting with the A23, have a Reduced Serial Bus
(RSB) controller. This is used to talk to the PMIC, and later with the
A80 and A83 platform, the audio codec IC.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../devicetree/bindings/rsb/rsb-sunxi.txt          | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rsb/rsb-sunxi.txt

diff --git a/Documentation/devicetree/bindings/rsb/rsb-sunxi.txt b/Documentation/devicetree/bindings/rsb/rsb-sunxi.txt
new file mode 100644
index 000000000000..057d24b84628
--- /dev/null
+++ b/Documentation/devicetree/bindings/rsb/rsb-sunxi.txt
@@ -0,0 +1,34 @@
+
+* Allwinner RSB (Reduced Serial Bus) controller
+
+Required properties :
+
+ - reg             : Offset and length of the register set for the controller.
+ - compatible      : Shall be "allwinner,sun8i-a23-rsb".
+ - interrupts      : The interrupt line associated to the RSB controller.
+ - clocks          : The gate clk associated to the RSB controller.
+ - resets          : The reset line associated to the RSB controller.
+ - #address-cells  : shall be 2
+ - #size-cells     : shall be 0
+
+Optional properties :
+
+ - clock-frequency : Desired RSB bus clock frequency in Hz. Maximum is 20MHz.
+		     If not set the current hardware setting shall be used.
+
+See rsb.txt for the generic RSB bindings for RSB slaves / child nodes.
+
+Example:
+
+	rsb at 01f03400 {
+		compatible = "allwinner,sun8i-a23-rsb";
+		reg = <0x01f03400 0x400>;
+		interrupts = <0 39 4>;
+		clocks = <&apb0_gates 3>;
+		clock-frequency = <3000000>;
+		resets = <&apb0_rst 3>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		/* child nodes ... */
+	};
-- 
2.5.0
